import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/decision/domain/usecases/soft_delete_decision_usecase.dart';
import '../../../../helpers/mock_decision_repository.dart';

void main() {
  late MockDecisionRepository mockRepository;
  late SoftDeleteDecisionUseCase useCase;

  setUp(() {
    mockRepository = MockDecisionRepository();
    useCase = SoftDeleteDecisionUseCase(mockRepository);
  });

  group('SoftDeleteDecisionUseCase', () {
    test('should soft delete existing decision', () async {
      final decision = await mockRepository.saveDecision(
        const Decision(title: 'To Delete'),
      );

      await useCase(decision.id!);

      final deleted = await mockRepository.getDecision(decision.id!);
      expect(deleted?.deletedAt, isNotNull);
    });

    test('should not throw when deleting non-existent decision', () async {
      expect(() => useCase('non-existent-id'), returnsNormally);
    });

    test('should handle repository errors', () async {
      mockRepository.shouldThrowOnDelete = true;
      mockRepository.errorMessage = 'Delete operation failed';

      expect(
        () => useCase('some-id'),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Delete operation failed'),
          ),
        ),
      );
    });

    test('should mark decision as deleted without removing it', () async {
      final decision = await mockRepository.saveDecision(
        const Decision(title: 'To Delete'),
      );

      await useCase(decision.id!);

      // Decision should still be retrievable (soft delete)
      final deleted = await mockRepository.getDecision(decision.id!);
      expect(deleted, isNotNull);
      expect(deleted?.id, decision.id);
    });
  });
}
