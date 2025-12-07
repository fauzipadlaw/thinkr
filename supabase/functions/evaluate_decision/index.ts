import type {
  DecisionPayload,
  DecisionResult,
  DecisionMethod,
  EvaluateDecisionResponse,
} from '../_shared/types.ts';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
};

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const body = (await req.json()) as DecisionPayload;
    validatePayload(body);

    let result: DecisionResult;
    switch (body.method) {
      case 'weightedSum':
        result = evaluateWeightedSum(body);
        break;
      case 'ahp':
        result = evaluateAhp(body);
        break;
      case 'fuzzyWeightedSum':
        result = evaluateFuzzyWeightedSum(body);
        break;
      default:
        return json({ error: 'Unknown method.' }, 400);
    }

    const response: EvaluateDecisionResponse = {
      bestOptionId: result.bestOptionId,
      scores: result.scores,
      ranking: result.ranking,
      errorRate: result.errorRate,
      debug: result.debug,
    };

    return json(response);
  } catch (error) {
    console.error('evaluate_decision error:', error);
    return json({ error: `${error}` }, 400);
  }
});

// ---------- Weighted Sum Model ----------

function evaluateWeightedSum(
  decision: DecisionPayload,
  overrideWeights?: Map<string, number>,
): DecisionResult {
  if (!decision.options.length) throw new Error('At least one option is required.');
  if (!decision.criteria.length) throw new Error('At least one criterion is required.');

  const weightMap = overrideWeights ?? new Map<string, number>();
  if (!overrideWeights) {
    for (const c of decision.criteria) {
      weightMap.set(c.id, Math.max(0, c.weight ?? 0));
    }
  }

  const { optionTotals, normalizedWeights, totalWeight } = computeTotals(
    decision,
    weightMap,
  );

  const ranking = Object.entries(optionTotals)
    .sort((a, b) => b[1] - a[1])
    .map(([id]) => id);

  const marginReliability = computeMarginReliability(optionTotals);
  const stability = computeStability(decision, weightMap, ranking[0]);
  const combinedReliability = clamp01(marginReliability * 0.7 + stability * 0.3);
  const errorRate = 1 - combinedReliability;

  return {
    bestOptionId: ranking[0],
    scores: optionTotals,
    ranking,
    debug: {
      totalWeight,
      normalizedWeights: Object.fromEntries(normalizedWeights),
      marginNormalized: margin(optionTotals),
      marginReliability,
      stability,
      combinedReliability,
    },
    errorRate,
  };
}

// ---------- AHP ----------
function evaluateAhp(decision: DecisionPayload): DecisionResult {
  const derived = decision.ahpMatrix
    ? deriveAhpWeights(decision.ahpMatrix)
    : null;
  const fallback = normalizeWeights(
    decision.criteria.map((c) => Math.max(0, c.weight ?? 0)),
  );
  const effectiveWeights =
    derived && derived.length === decision.criteria.length ? derived : fallback;

  const weightMap = new Map(
    decision.criteria.map((c, i) => [c.id, effectiveWeights[i]]),
  );

  const base = evaluateWeightedSum(decision, weightMap);
  const cr =
    decision.ahpMatrix && derived
      ? consistencyRatio(decision.ahpMatrix, derived)
      : null;

  return {
    ...base,
    debug: {
      ...(base.debug ?? {}),
      method: 'ahp',
      ahpWeights: effectiveWeights,
      ahpConsistencyRatio: cr,
    },
  };
}

// ---------- Fuzzy Weighted Sum ----------
function evaluateFuzzyWeightedSum(decision: DecisionPayload): DecisionResult {
  const spread = Number(decision.fuzzySpread ?? 1);
  if (!Number.isFinite(spread) || spread <= 0) {
    throw new Error('Fuzzy spread must be > 0.');
  }
  const weightMap = new Map<string, FuzzyNumber>();
  for (const c of decision.criteria) {
    weightMap.set(c.id, toFuzzy(Math.max(0, c.weight ?? 0), spread));
  }

  const optionTotals: Record<string, FuzzyNumber> = {};

  for (const option of decision.options) {
    let acc: FuzzyNumber | null = null;
    for (const criterion of decision.criteria) {
      const key = `${option.id}|${criterion.id}`;
      const rawScore = Number(decision.scores[key] ?? 0);
      const s = toFuzzy(rawScore, spread);
      const w = weightMap.get(criterion.id) ?? toFuzzy(0, spread);
      const weighted = multiplyFuzzy(w, s);
      acc = acc == null ? weighted : addFuzzy(acc, weighted);
    }
    if (!acc) throw new Error('Fuzzy aggregation failed.');
    optionTotals[option.id] = acc;
  }

  const defuzzified: Record<string, number> = {};
  for (const [id, tri] of Object.entries(optionTotals)) {
    defuzzified[id] = centroid(tri);
  }

  const marginReliability = computeMarginReliability(defuzzified);
  const overlap = fuzzyOverlapRatio(defuzzified);
  const overlapReliability = 1 - overlap;
  const stability = computeStability(decision, toNumberWeights(weightMap), null, 0.05);
  const combinedReliability = clamp01(
    marginReliability * 0.5 + stability * 0.2 + overlapReliability * 0.3,
  );

  return {
    bestOptionId: Object.entries(defuzzified)
      .sort((a, b) => b[1] - a[1])[0][0],
    scores: defuzzified,
    ranking: Object.entries(defuzzified)
      .sort((a, b) => b[1] - a[1])
      .map(([id]) => id),
    errorRate: 1 - combinedReliability,
    debug: {
      method: 'fuzzyWeightedSum',
      fuzzyOverlapRatio: fuzzyOverlapRatio(defuzzified),
      fuzzyTotals: optionTotals,
      marginReliability,
      stability,
      overlapReliability,
      combinedReliability,
    },
  };
}

// ---------- Error Rate ----------

function margin(optionTotals: Record<string, number>): number {
  const sorted = Object.values(optionTotals).sort((a, b) => b - a);
  if (sorted.length < 2) return 1;
  const best = sorted[0];
  const second = sorted[1];
  if (best <= 0) return 0;
  return (best - second) / Math.max(best, 1e-6);
}

function computeErrorRate(optionTotals: Record<string, number>): number {
  const m = margin(optionTotals);
  // Confidence is margin (0..1), error is inverse.
  const confidence = Math.max(0, Math.min(1, m));
  const error = 1 - confidence;
  return Number(error.toFixed(3));
}

function computeMarginReliability(optionTotals: Record<string, number>): number {
  const m = margin(optionTotals);
  return Number(clamp01(m).toFixed(3));
}

function normalizeWeights(weights: number[]): number[] {
  const sum = weights.reduce((s, v) => s + v, 0) || 1;
  return weights.map((v) => v / sum);
}

// For fuzzy methods: approximate overlap using relative spread between top two scores.
function fuzzyOverlapRatio(optionTotals: Record<string, number>): number {
  const sorted = Object.values(optionTotals).sort((a, b) => b - a);
  if (sorted.length < 2) return 0;
  const best = sorted[0];
  const second = sorted[1];
  if (best <= 0) return 1; // undefined => full overlap
  return Math.max(0, Math.min(1, second / best));
}

function computeTotals(decision: DecisionPayload, weightMap: Map<string, number>) {
  const totalWeight = Array.from(weightMap.values()).reduce((acc, w) => acc + w, 0);
  if (totalWeight <= 0) throw new Error('Total criterion weight must be > 0.');

  const normalizedWeights = Array.from(weightMap.entries()).map(([id, w]) => [
    id,
    w / totalWeight,
  ]);

  const optionTotals: Record<string, number> = {};
  for (const option of decision.options) {
    let scoreSum = 0;
    for (const criterion of decision.criteria) {
      const key = `${option.id}|${criterion.id}`;
      const rawScore = Number(decision.scores[key] ?? 0);
      const normalizedWeight = weightMap.get(criterion.id)! / totalWeight;
      scoreSum += normalizedWeight * rawScore;
    }
    optionTotals[option.id] = scoreSum;
  }

  return { optionTotals, normalizedWeights, totalWeight };
}

function computeStability(
  decision: DecisionPayload,
  baseWeights: Map<string, number>,
  baselineBest?: string | null,
  jitter = 0.05,
  runs = 64,
): number {
  if (!decision.criteria.length || !decision.options.length) return 0;
  const baseTotals = computeTotals(decision, baseWeights).optionTotals;
  const baseline = baselineBest ?? bestOf(baseTotals);
  let stableCount = 0;

  for (let i = 0; i < runs; i++) {
    const perturbed = new Map<string, number>();
    for (const c of decision.criteria) {
      const base = baseWeights.get(c.id) ?? 0;
      const factor = 1 + (Math.random() * 2 - 1) * jitter;
      perturbed.set(c.id, Math.max(0, base * factor));
    }
    const totals = computeTotals(decision, perturbed).optionTotals;
    if (bestOf(totals) === baseline) stableCount += 1;
  }

  return Number((stableCount / runs).toFixed(3));
}

function bestOf(optionTotals: Record<string, number>): string | null {
  const entries = Object.entries(optionTotals);
  if (!entries.length) return null;
  entries.sort((a, b) => b[1] - a[1]);
  return entries[0][0];
}

function toNumberWeights(fuzzyWeights: Map<string, FuzzyNumber>): Map<string, number> {
  const map = new Map<string, number>();
  for (const [id, f] of fuzzyWeights.entries()) {
    map.set(id, f.b);
  }
  return map;
}

function clamp01(x: number) {
  return Math.min(1, Math.max(0, x));
}

// ---------- Validation ----------

function validatePayload(body: DecisionPayload) {
  if (!body || typeof body !== 'object') {
    throw new Error('Invalid payload.');
  }
  if (!Array.isArray(body.options)) throw new Error('options must be an array.');
  if (!Array.isArray(body.criteria)) throw new Error('criteria must be an array.');
  if (typeof body.scores !== 'object') throw new Error('scores must be an object.');

  const method: DecisionMethod = body.method ?? 'weightedSum';
  if (!['weightedSum', 'ahp', 'fuzzyWeightedSum'].includes(method)) {
    throw new Error('Unsupported method.');
  }
}

// ---------- Helpers ----------

type FuzzyNumber = { a: number; b: number; c: number };

function toFuzzy(value: number, spread: number): FuzzyNumber {
  return {
    a: Math.max(0, value - spread),
    b: value,
    c: value + spread,
  };
}

function addFuzzy(x: FuzzyNumber, y: FuzzyNumber): FuzzyNumber {
  return { a: x.a + y.a, b: x.b + y.b, c: x.c + y.c };
}

function multiplyFuzzy(x: FuzzyNumber, y: FuzzyNumber): FuzzyNumber {
  return { a: x.a * y.a, b: x.b * y.b, c: x.c * y.c };
}

function centroid(x: FuzzyNumber): number {
  return (x.a + x.b + x.c) / 3;
}

// AHP helpers
function deriveAhpWeights(matrix: number[][]): number[] | null {
  const n = matrix.length;
  if (!n) return null;
  if (!matrix.every((row) => row.length === n)) return null;
  // If all off-diagonal entries are ~1, treat as no comparisons.
  let hasSignal = false;
  for (let i = 0; i < n; i++) {
    for (let j = 0; j < n; j++) {
      if (i === j) continue;
      if (Math.abs(matrix[i][j] - 1) > 1e-6) {
        hasSignal = true;
        break;
      }
    }
    if (hasSignal) break;
  }
  if (!hasSignal) return null;

  let vec = Array(n).fill(1 / n);
  for (let iter = 0; iter < 30; iter++) {
    const next = Array(n).fill(0);
    for (let i = 0; i < n; i++) {
      for (let j = 0; j < n; j++) {
        next[i] += matrix[i][j] * vec[j];
      }
    }
    const sum = next.reduce((s, v) => s + v, 0) || 1;
    vec = next.map((v) => v / sum);
  }
  return vec;
}

function consistencyRatio(matrix: number[][], weights: number[]): number | null {
  const n = matrix.length;
  if (!n) return null;
  const aw = Array(n).fill(0);
  for (let i = 0; i < n; i++) {
    for (let j = 0; j < n; j++) {
      aw[i] += matrix[i][j] * weights[j];
    }
  }
  let lambdaMax = 0;
  for (let i = 0; i < n; i++) {
    if (weights[i] === 0) continue;
    lambdaMax += aw[i] / weights[i];
  }
  lambdaMax /= n;
  const ci = (lambdaMax - n) / (n - 1);
  const ri = randomIndex(n);
  if (ri === 0) return 0;
  return Number((ci / ri).toFixed(3));
}

function randomIndex(n: number): number {
  const table: Record<number, number> = {
    1: 0,
    2: 0,
    3: 0.58,
    4: 0.9,
    5: 1.12,
    6: 1.24,
    7: 1.32,
    8: 1.41,
    9: 1.45,
    10: 1.49,
  };
  return table[n] ?? 1.49;
}

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      'Content-Type': 'application/json',
      ...corsHeaders,
    },
  });
}
