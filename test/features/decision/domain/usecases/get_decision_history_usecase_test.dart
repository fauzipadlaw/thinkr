import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/decision/domain/usecases/get_decision_history_usecase.dart';
import '../../../../helpers/mock_decision_repository.dart';

void main() {
  late MockDecisionRepository mockRepository;
  late GetDecisionHistoryUseCase useCase;

  setUp(() {
    mockRepository = MockDecisionRepository();
    useCase = GetDecisionHistoryUseCase(mockRepository);
  });

  group('GetDecisionHistoryUseCase', () {
    test('should return empty list when no decisions exist', () async {
      final result = await useCase();

      expect(result, isEmpty);
    });

    test('should return list of decisions', () async {
      // Add some decisions to mock repository
      await mockRepository.saveDecision(const Decision(title: 'Decision 1'));
      await mockRepository.saveDecision(const Decision(title: 'Decision 2'));
      await mockRepository.saveDecision(const Decision(title: 'Decision 3'));

      final result = await useCase();

      expect(result.length, 3);
    });

    test('should respect limit parameter', () async {
      for (int i = 0; i < 25; i++) {
        await mockRepository.saveDecision(Decision(title: 'Decision $i'));
      }

      final result = await useCase(limit: 10);

      expect(result.length, 10);
    });

    test('should respect offset parameter', () async {
      for (int i = 0; i < 25; i++) {
        await mockRepository.saveDecision(Decision(title: 'Decision $i'));
      }

      final firstPage = await useCase(limit: 10, offset: 0);
      final secondPage = await useCase(limit: 10, offset: 10);

      expect(firstPage.length, 10);
      expect(secondPage.length, 10);
      expect(firstPage.first.title, isNot(secondPage.first.title));
    });

    test('should filter by query parameter', () async {
      await mockRepository.saveDecision(const Decision(title: 'Buy a Car'));
      await mockRepository.saveDecision(const Decision(title: 'Buy a House'));
      await mockRepository.saveDecision(const Decision(title: 'Sell Stock'));

      final result = await useCase(query: 'Buy');

      expect(result.length, 2);
      expect(result.every((d) => d.title.contains('Buy')), isTrue);
    });

    test('should handle case-insensitive search', () async {
      await mockRepository.saveDecision(const Decision(title: 'BUY A CAR'));
      await mockRepository.saveDecision(const Decision(title: 'buy a house'));

      final result = await useCase(query: 'buy');

      expect(result.length, 2);
    });

    test('should use default limit when not specified', () async {
      for (int i = 0; i < 25; i++) {
        await mockRepository.saveDecision(Decision(title: 'Decision $i'));
      }

      final result = await useCase();

      expect(result.length, 20); // Default limit
    });

    test('should handle repository errors', () async {
      mockRepository.shouldThrowOnGet = true;
      mockRepository.errorMessage = 'Network error';

      expect(
        () => useCase(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Network error'),
          ),
        ),
      );
    });
  });
}
