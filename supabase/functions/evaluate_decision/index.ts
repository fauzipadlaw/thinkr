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
      case 'fuzzyWeightedSum':
        return json(
          { error: `Method ${body.method} not implemented on Edge yet.` },
          501,
        );
      default:
        return json({ error: 'Unknown method.' }, 400);
    }

    const response: EvaluateDecisionResponse = {
      bestOptionId: result.bestOptionId,
      scores: result.scores,
      ranking: result.ranking,
      debug: result.debug,
    };

    return json(response);
  } catch (error) {
    console.error('evaluate_decision error:', error);
    return json({ error: `${error}` }, 400);
  }
});

// ---------- Weighted Sum Model ----------

function evaluateWeightedSum(decision: DecisionPayload): DecisionResult {
  if (!decision.options.length) throw new Error('At least one option is required.');
  if (!decision.criteria.length) throw new Error('At least one criterion is required.');

  const weightMap = new Map<string, number>();
  for (const c of decision.criteria) {
    weightMap.set(c.id, Math.max(0, c.weight ?? 0));
  }

  const totalWeight = Array.from(weightMap.values()).reduce((acc, w) => acc + w, 0);
  if (totalWeight <= 0) throw new Error('Total criterion weight must be > 0.');

  const optionTotals: Record<string, number> = {};

  for (const option of decision.options) {
    let scoreSum = 0;
    for (const criterion of decision.criteria) {
      const key = `${option.id}|${criterion.id}`;
      const rawScore = Number(decision.scores[key] ?? 0);
      const normalizedWeight = (weightMap.get(criterion.id) ?? 0) / totalWeight;
      scoreSum += normalizedWeight * rawScore;
    }
    optionTotals[option.id] = scoreSum;
  }

  const ranking = Object.entries(optionTotals)
    .sort((a, b) => b[1] - a[1])
    .map(([id]) => id);

  return {
    bestOptionId: ranking[0],
    scores: optionTotals,
    ranking,
    debug: {
      totalWeight,
      normalizedWeights: Object.fromEntries(
        Array.from(weightMap.entries()).map(([id, w]) => [id, w / totalWeight]),
      ),
    },
  };
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

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      'Content-Type': 'application/json',
      ...corsHeaders,
    },
  });
}
