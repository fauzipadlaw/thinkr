export type DecisionMethod = 'weightedSum' | 'ahp' | 'fuzzyWeightedSum';

export interface DecisionOption {
  id: string;
  label: string;
  description?: string | null;
}

export interface DecisionCriterion {
  id: string;
  label: string;
  weight: number;
}

export type ScoreKey = string; // optionId|criterionId

export interface DecisionPayload {
  method: DecisionMethod;
  title: string;
  description?: string | null;
  options: DecisionOption[];
  criteria: DecisionCriterion[];
  scores: Record<ScoreKey, number>;
}

export interface DecisionResult {
  bestOptionId: string;
  scores: Record<string, number>;
  ranking: string[];
  debug?: Record<string, unknown>;
}

export interface EvaluateDecisionResponse {
  bestOptionId: string;
  scores: Record<string, number>;
  ranking: string[];
  debug?: Record<string, unknown>;
}
