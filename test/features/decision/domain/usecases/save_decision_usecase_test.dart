import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/decision/domain/usecases/save_decision_usecase.dart';
import '../../../../helpers/mock_decision_repository.dart';

void main() {
  late MockDecisionRepository mockRepository;
  late SaveDecisionUseCase useCase;

  setUp(() {
    mockRepository = MockDecisionRepository();
    useCase = SaveDecisionUseCase(mockRepository);
  });

  group('SaveDecisionUseCase', () {
    test('should save decision and return it with id', () async {
      const decision = Decision(title: 'Test Decision');

      final saved = await useCase(decision);

      expect(saved.id, isNotNull);
      expect(saved.title, 'Test Decision');
      expect(saved.createdAt, isNotNull);
      expect(saved.updatedAt, isNotNull);
    });

    test('should update existing decision', () async {
      const decision = Decision(id: 'existing-123', title: 'Updated Title');

      final saved = await useCase(decision);

      expect(saved.id, 'existing-123');
      expect(saved.title, 'Updated Title');
      expect(saved.updatedAt, isNotNull);
    });

    test('should preserve decision data', () async {
      const decision = Decision(
        title: 'Test',
        description: 'Description',
        method: DecisionMethod.ahp,
        options: [DecisionOption(id: 'opt-1', label: 'Option 1')],
        criteria: [DecisionCriterion(id: 'crit-1', label: 'Criterion 1')],
        scores: {'opt-1|crit-1': 8.0},
      );

      final saved = await useCase(decision);

      expect(saved.title, decision.title);
      expect(saved.description, decision.description);
      expect(saved.method, decision.method);
      expect(saved.options.length, decision.options.length);
      expect(saved.criteria.length, decision.criteria.length);
      expect(saved.scores, decision.scores);
    });

    test('should handle repository errors', () async {
      mockRepository.shouldThrowOnSave = true;
      mockRepository.errorMessage = 'Database error';

      const decision = Decision(title: 'Test');

      expect(
        () => useCase(decision),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Database error'),
        )),
      );
    });

    test('should save decision with result', () async {
      const result = DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 8.5},
        ranking: ['opt-1'],
      );

      const decision = Decision(
        title: 'Evaluated',
        result: result,
      );

      final saved = await useCase(decision);

      expect(saved.result, isNotNull);
      expect(saved.result?.bestOptionId, 'opt-1');
    });
  });
}