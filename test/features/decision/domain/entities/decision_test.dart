import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';

void main() {
  group('DecisionOption', () {
    test('should create option with required fields', () {
      const option = DecisionOption(id: 'opt-1', label: 'Option A');

      expect(option.id, 'opt-1');
      expect(option.label, 'Option A');
      expect(option.description, isNull);
    });

    test('should create option with description', () {
      const option = DecisionOption(
        id: 'opt-1',
        label: 'Option A',
        description: 'A detailed description',
      );

      expect(option.description, 'A detailed description');
    });

    test('should support copyWith', () {
      const option = DecisionOption(id: 'opt-1', label: 'Option A');
      final updated = option.copyWith(label: 'Option B');

      expect(updated.id, 'opt-1');
      expect(updated.label, 'Option B');
    });
  });

  group('DecisionCriterion', () {
    test('should create criterion with default weight', () {
      const criterion = DecisionCriterion(id: 'crit-1', label: 'Cost');

      expect(criterion.id, 'crit-1');
      expect(criterion.label, 'Cost');
      expect(criterion.weight, 1.0);
    });

    test('should create criterion with custom weight', () {
      const criterion = DecisionCriterion(
        id: 'crit-1',
        label: 'Quality',
        weight: 2.5,
      );

      expect(criterion.weight, 2.5);
    });

    test('should support copyWith for weight changes', () {
      const criterion = DecisionCriterion(id: 'crit-1', label: 'Cost');
      final updated = criterion.copyWith(weight: 3.0);

      expect(updated.weight, 3.0);
      expect(updated.id, 'crit-1');
      expect(updated.label, 'Cost');
    });
  });

  group('DecisionResult', () {
    test('should create result with required fields', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5, 'opt-2': 6.3},
        ranking: ['opt-1', 'opt-2'],
      );

      expect(result.bestOptionId, 'opt-1');
      expect(result.scores['opt-1'], 8.5);
      expect(result.scores['opt-2'], 6.3);
      expect(result.ranking, ['opt-1', 'opt-2']);
      expect(result.errorRate, 0.0);
    });

    test('should create result with error rate', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5},
        ranking: ['opt-1'],
        errorRate: 0.15,
      );

      expect(result.errorRate, 0.15);
    });

    test('should support debug information', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5},
        ranking: ['opt-1'],
        debug: {'consistency': 0.95, 'method': 'AHP'},
      );

      expect(result.debug?['consistency'], 0.95);
      expect(result.debug?['method'], 'AHP');
    });

    test('should handle empty scores', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {},
        ranking: [],
      );

      expect(result.scores, isEmpty);
      expect(result.ranking, isEmpty);
    });
  });

  group('Decision', () {
    test('should create empty decision', () {
      const decision = Decision.empty;

      expect(decision.title, '');
      expect(decision.method, DecisionMethod.weightedSum);
      expect(decision.options, isEmpty);
      expect(decision.criteria, isEmpty);
      expect(decision.scores, isEmpty);
    });

    test('should create decision with title and method', () {
      const decision = Decision(title: 'Buy a Car', method: DecisionMethod.ahp);

      expect(decision.title, 'Buy a Car');
      expect(decision.method, DecisionMethod.ahp);
    });

    test('should support all decision methods', () {
      const wsm = Decision(title: 'Test', method: DecisionMethod.weightedSum);
      const ahp = Decision(title: 'Test', method: DecisionMethod.ahp);
      const fuzzy = Decision(
        title: 'Test',
        method: DecisionMethod.fuzzyWeightedSum,
      );

      expect(wsm.method, DecisionMethod.weightedSum);
      expect(ahp.method, DecisionMethod.ahp);
      expect(fuzzy.method, DecisionMethod.fuzzyWeightedSum);
    });

    test('should store options and criteria', () {
      const decision = Decision(
        title: 'Test',
        options: [
          DecisionOption(id: 'opt-1', label: 'Option 1'),
          DecisionOption(id: 'opt-2', label: 'Option 2'),
        ],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
      );

      expect(decision.options.length, 2);
      expect(decision.criteria.length, 1);
    });

    test('should store scores with proper keys', () {
      const decision = Decision(
        title: 'Test',
        scores: {'opt-1|crit-1': 8.0, 'opt-2|crit-1': 7.5},
      );

      expect(decision.scores['opt-1|crit-1'], 8.0);
      expect(decision.scores['opt-2|crit-1'], 7.5);
    });

    test('should support AHP matrix', () {
      final decision = Decision(
        title: 'Test',
        method: DecisionMethod.ahp,
        ahpMatrix: [
          [1.0, 3.0],
          [1 / 3, 1.0],
        ],
      );

      expect(decision.ahpMatrix, isNotNull);
      expect(decision.ahpMatrix!.length, 2);
      expect(decision.ahpMatrix![0][1], 3.0);
    });

    test('should support fuzzy spread', () {
      const decision = Decision(
        title: 'Test',
        method: DecisionMethod.fuzzyWeightedSum,
        fuzzySpread: 1.5,
      );

      expect(decision.fuzzySpread, 1.5);
    });

    test('should support result', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5},
        ranking: ['opt-1'],
      );

      const decision = Decision(title: 'Test', result: result);

      expect(decision.result, isNotNull);
      expect(decision.result?.bestOptionId, 'opt-1');
    });

    test('should support timestamps', () {
      final now = DateTime.now();
      final decision = Decision(title: 'Test', createdAt: now, updatedAt: now);

      expect(decision.createdAt, now);
      expect(decision.updatedAt, now);
      expect(decision.deletedAt, isNull);
    });

    test('should support soft delete', () {
      final deletedAt = DateTime.now();
      final decision = Decision(title: 'Test', deletedAt: deletedAt);

      expect(decision.deletedAt, deletedAt);
    });

    test('should support copyWith for updates', () {
      const original = Decision(title: 'Original');
      final updated = original.copyWith(
        title: 'Updated',
        description: 'New description',
      );

      expect(updated.title, 'Updated');
      expect(updated.description, 'New description');
    });
  });
}
