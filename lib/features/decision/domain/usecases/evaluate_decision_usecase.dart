import 'package:injectable/injectable.dart';

import '../entities/decision.dart';

@lazySingleton
class EvaluateDecisionUseCase {
  const EvaluateDecisionUseCase();

  DecisionResult call(Decision decision) {
    if (decision.options.isEmpty) {
      throw StateError('Decision requires at least one option.');
    }

    if (decision.criteria.isEmpty) {
      throw StateError('Decision requires at least one criterion.');
    }

    // Extract weights
    final weightMap = <CriterionId, double>{
      for (final c in decision.criteria) c.id: c.weight,
    };

    // Normalize weights to sum = 1.0
    final totalWeight = weightMap.values.fold<double>(0, (a, b) => a + b);
    if (totalWeight <= 0) {
      throw StateError('Total criterion weight must be > 0.');
    }

    // Score aggregation: option → weightedScore
    final optionTotals = <OptionId, double>{};

    for (final option in decision.options) {
      double scoreSum = 0;

      for (final criterion in decision.criteria) {
        final key = _scoreKey(option.id, criterion.id);
        final rawScore = decision.scores[key] ?? 0;
        final normalizedWeight = weightMap[criterion.id]! / totalWeight;

        scoreSum += normalizedWeight * rawScore;
      }

      optionTotals[option.id] = scoreSum;
    }

    // Sort from best to worst
    final ranking = optionTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return DecisionResult(
      bestOptionId: ranking.first.key,
      scores: optionTotals,
      ranking: ranking.map((e) => e.key).toList(),
    );
  }

  static String _scoreKey(OptionId option, CriterionId criterion) {
    return '$option|$criterion';
  }
}
