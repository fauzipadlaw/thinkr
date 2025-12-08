import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/decision/presentation/decision_result_state.dart';

void main() {
  group('DecisionResultState', () {
    test('fromDecision should create state without result', () {
      const decision = Decision(title: 'Test', options: [], criteria: []);

      final state = DecisionResultState.fromDecision(decision);

      expect(state.hasResult, isFalse);
      expect(state.ranking, isEmpty);
      expect(state.best, isNull);
    });

    test('fromDecision should create state with result', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5, 'opt-2': 7.2},
        ranking: ['opt-1', 'opt-2'],
      );

      const decision = Decision(
        title: 'Test',
        options: [
          DecisionOption(id: 'opt-1', label: 'Option 1'),
          DecisionOption(id: 'opt-2', label: 'Option 2'),
        ],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
        result: result,
      );

      final state = DecisionResultState.fromDecision(decision);

      expect(state.hasResult, isTrue);
      expect(state.ranking.length, 2);
      expect(state.best?.optionId, 'opt-1');
      expect(state.best?.label, 'Option 1');
      expect(state.best?.score, 8.5);
    });

    test('should generate ranking from scores when ranking is empty', () {
      const result = DecisionResult(
        bestOptionId: 'opt-2',
        scores: {'opt-1': 7.0, 'opt-2': 8.5, 'opt-3': 6.0},
        ranking: [],
      );

      const decision = Decision(
        title: 'Test',
        options: [
          DecisionOption(id: 'opt-1', label: 'Option 1'),
          DecisionOption(id: 'opt-2', label: 'Option 2'),
          DecisionOption(id: 'opt-3', label: 'Option 3'),
        ],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
        result: result,
      );

      final state = DecisionResultState.fromDecision(decision);

      expect(state.ranking.length, 3);
      expect(state.ranking[0].optionId, 'opt-2'); // Highest score
      expect(state.ranking[1].optionId, 'opt-1');
      expect(state.ranking[2].optionId, 'opt-3'); // Lowest score
    });

    test('should include error rate', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5},
        ranking: ['opt-1'],
        errorRate: 0.12,
      );

      const decision = Decision(
        title: 'Test',
        options: [DecisionOption(id: 'opt-1', label: 'Option 1')],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
        result: result,
      );

      final state = DecisionResultState.fromDecision(decision);

      expect(state.errorRate, 0.12);
    });

    test('should parse debug information', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5},
        ranking: ['opt-1'],
        debug: {
          'ahpConsistencyRatio': 0.05,
          'stability': 0.95,
          'overlapReliability': 0.87,
          'marginReliability': 0.92,
          'combinedReliability': 0.89,
        },
      );

      const decision = Decision(
        title: 'Test',
        options: [DecisionOption(id: 'opt-1', label: 'Option 1')],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
        result: result,
      );

      final state = DecisionResultState.fromDecision(decision);

      expect(state.ahpConsistency, 0.05);
      expect(state.stability, 0.95);
      expect(state.fuzzyOverlapReliability, 0.87);
      expect(state.marginReliability, 0.92);
      expect(state.combinedReliability, 0.89);
    });

    test('should handle missing debug fields', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5},
        ranking: ['opt-1'],
        debug: {'ahpConsistencyRatio': 0.05},
      );

      const decision = Decision(
        title: 'Test',
        options: [DecisionOption(id: 'opt-1', label: 'Option 1')],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
        result: result,
      );

      final state = DecisionResultState.fromDecision(decision);

      expect(state.ahpConsistency, 0.05);
      expect(state.stability, isNull);
      expect(state.fuzzyOverlapReliability, isNull);
    });

    test('should handle string values in debug', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5},
        ranking: ['opt-1'],
        debug: {
          'ahpConsistencyRatio': '0.05',
          'stability': '0.95',
        },
      );

      const decision = Decision(
        title: 'Test',
        options: [DecisionOption(id: 'opt-1', label: 'Option 1')],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
        result: result,
      );

      final state = DecisionResultState.fromDecision(decision);

      expect(state.ahpConsistency, 0.05);
      expect(state.stability, 0.95);
    });

    test('should use option label from options list', () {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5},
        ranking: ['opt-1'],
      );

      const decision = Decision(
        title: 'Test',
        options: [DecisionOption(id: 'opt-1', label: 'My Custom Label')],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
        result: result,
      );

      final state = DecisionResultState.fromDecision(decision);

      expect(state.best?.label, 'My Custom Label');
    });

    test('should fallback to option id when label not found', () {
      const result = DecisionResult(
        bestOptionId: 'opt-unknown',
        scores: {'opt-unknown': 8.5},
        ranking: ['opt-unknown'],
      );

      const decision = Decision(
        title: 'Test',
        options: [],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
        result: result,
      );

      final state = DecisionResultState.fromDecision(decision);

      expect(state.best?.label, 'opt-unknown');
    });
  });
}