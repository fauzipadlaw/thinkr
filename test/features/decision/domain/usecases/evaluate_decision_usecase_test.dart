import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/decision/domain/usecases/evaluate_decision_usecase.dart';
import '../../../../helpers/mock_decision_repository.dart';

void main() {
  late MockDecisionRepository mockRepository;
  late EvaluateDecisionUseCase useCase;

  setUp(() {
    mockRepository = MockDecisionRepository();
    useCase = EvaluateDecisionUseCase(mockRepository);
  });

  group('EvaluateDecisionUseCase', () {
    test('should successfully evaluate a valid decision', () async {
      final decision = Decision(
        title: 'Test Decision',
        options: const [
          DecisionOption(id: 'opt-1', label: 'Option 1'),
          DecisionOption(id: 'opt-2', label: 'Option 2'),
        ],
        criteria: const [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
        scores: const {'opt-1|crit-1': 8.0, 'opt-2|crit-1': 7.0},
      );

      final result = await useCase(decision);

      expect(result.bestOptionId, isNotEmpty);
      expect(result.scores, isNotEmpty);
      expect(result.ranking, isNotEmpty);
    });

    test('should throw StateError when decision has no options', () async {
      const decision = Decision(
        title: 'Test Decision',
        options: [],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
      );

      expect(
        () => useCase(decision),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('at least one option'),
          ),
        ),
      );
    });

    test('should throw StateError when decision has no criteria', () async {
      const decision = Decision(
        title: 'Test Decision',
        options: [DecisionOption(id: 'opt-1', label: 'Option 1')],
        criteria: [],
      );

      expect(
        () => useCase(decision),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('at least one criterion'),
          ),
        ),
      );
    });

    test('should handle repository errors gracefully', () async {
      mockRepository.shouldThrowOnEvaluate = true;
      mockRepository.errorMessage = 'Evaluation service unavailable';

      final decision = Decision(
        title: 'Test Decision',
        options: const [DecisionOption(id: 'opt-1', label: 'Option 1')],
        criteria: const [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
      );

      expect(
        () => useCase(decision),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Evaluation service unavailable'),
          ),
        ),
      );
    });

    test('should pass through decision with all methods', () async {
      for (final method in DecisionMethod.values) {
        final decision = Decision(
          title: 'Test',
          method: method,
          options: const [DecisionOption(id: 'opt-1', label: 'Option 1')],
          criteria: const [
            DecisionCriterion(id: 'crit-1', label: 'Criterion 1'),
          ],
        );

        final result = await useCase(decision);
        expect(result, isNotNull);
      }
    });
  });
}
