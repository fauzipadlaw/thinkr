import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/decision/domain/usecases/get_decision_history_usecase.dart';
import 'package:thinkr/features/decision/domain/usecases/soft_delete_decision_usecase.dart';
import 'package:thinkr/features/decision/presentation/history/decision_history_cubit.dart';
import '../../../../helpers/mock_decision_repository.dart';

void main() {
  late MockDecisionRepository mockRepository;
  late GetDecisionHistoryUseCase getHistoryUseCase;
  late SoftDeleteDecisionUseCase softDeleteUseCase;
  late DecisionHistoryCubit cubit;

  setUp(() {
    mockRepository = MockDecisionRepository();
    getHistoryUseCase = GetDecisionHistoryUseCase(mockRepository);
    softDeleteUseCase = SoftDeleteDecisionUseCase(mockRepository);
    cubit = DecisionHistoryCubit(getHistoryUseCase, softDeleteUseCase);
  });

  tearDown(() {
    cubit.close();
    mockRepository.clear();
  });

  group('DecisionHistoryCubit', () {
    test('initial state should be correct', () {
      expect(cubit.state.decisions, isEmpty);
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.isLoadingMore, isFalse);
      expect(cubit.state.hasMore, isTrue);
      expect(cubit.state.page, 0);
      expect(cubit.state.searchTerm, '');
    });

    test('load should fetch decisions', () async {
      await mockRepository.saveDecision(const Decision(title: 'Decision 1'));
      await mockRepository.saveDecision(const Decision(title: 'Decision 2'));

      await cubit.load();

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.decisions.length, 2);
      expect(cubit.state.errorMessage, isNull);
    });

    test('load should set loading state', () async {
      // Listen to the stream to capture the loading state
      final states = <DecisionHistoryState>[];
      final subscription = cubit.stream.listen(states.add);

      await cubit.load();
      await subscription.cancel();

      // Check that at some point isLoading was true
      expect(states.any((state) => state.isLoading), isTrue);
    });

    test('load should handle errors', () async {
      mockRepository.shouldThrowOnGet = true;
      mockRepository.errorMessage = 'Network error';

      await cubit.load();

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.errorMessage, contains('Network error'));
    });

    test('load should set hasMore based on results', () async {
      for (int i = 0; i < 10; i++) {
        await mockRepository.saveDecision(Decision(title: 'Decision $i'));
      }

      await cubit.load();

      expect(cubit.state.hasMore, isTrue);
    });

    test(
      'load should set hasMore to false when results are less than page size',
      () async {
        await mockRepository.saveDecision(const Decision(title: 'Decision 1'));

        await cubit.load();

        expect(cubit.state.hasMore, isFalse);
      },
    );

    test('refresh should reload from first page', () async {
      await mockRepository.saveDecision(const Decision(title: 'Decision 1'));
      await cubit.load();

      await mockRepository.saveDecision(const Decision(title: 'Decision 2'));
      await cubit.refresh();

      expect(cubit.state.decisions.length, 2);
      expect(cubit.state.page, 0);
    });

    test('loadMore should append decisions', () async {
      for (int i = 0; i < 15; i++) {
        await mockRepository.saveDecision(Decision(title: 'Decision $i'));
      }

      await cubit.load();
      final initialCount = cubit.state.decisions.length;

      await cubit.loadMore();

      expect(cubit.state.decisions.length, greaterThan(initialCount));
    });

    test('loadMore should not load when already loading', () async {
      for (int i = 0; i < 20; i++) {
        await mockRepository.saveDecision(Decision(title: 'Decision $i'));
      }

      await cubit.load();
      cubit.loadMore();
      cubit.loadMore(); // Second call should be ignored

      await Future.delayed(const Duration(milliseconds: 100));
      expect(cubit.state.isLoadingMore, isFalse);
    });

    test('loadMore should not load when hasMore is false', () async {
      await mockRepository.saveDecision(const Decision(title: 'Decision 1'));
      await cubit.load();

      expect(cubit.state.hasMore, isFalse);

      final beforeCount = cubit.state.decisions.length;
      await cubit.loadMore();

      expect(cubit.state.decisions.length, beforeCount);
    });

    test('goToPage should load specific page', () async {
      for (int i = 0; i < 25; i++) {
        await mockRepository.saveDecision(Decision(title: 'Decision $i'));
      }

      await cubit.load();
      await cubit.goToPage(1);

      expect(cubit.state.page, 1);
      expect(cubit.state.decisions.length, 10);
    });

    test('goToPage should not accept negative pages', () async {
      await cubit.goToPage(-1);

      expect(cubit.state.page, 0);
    });

    test('delete should remove decision from list', () async {
      final decision = await mockRepository.saveDecision(
        const Decision(title: 'To Delete'),
      );
      await cubit.load();

      expect(cubit.state.decisions.length, 1);

      await cubit.delete(decision.id!);

      expect(cubit.state.decisions.length, 0);
      expect(cubit.state.isDeleting, isFalse);
    });

    test('delete should handle errors', () async {
      mockRepository.shouldThrowOnDelete = true;
      mockRepository.errorMessage = 'Delete failed';

      await cubit.delete('some-id');

      expect(cubit.state.errorMessage, contains('Delete failed'));
      expect(cubit.state.isDeleting, isFalse);
    });

    test('setSearchTerm should filter results', () async {
      await mockRepository.saveDecision(const Decision(title: 'Buy a Car'));
      await mockRepository.saveDecision(const Decision(title: 'Buy a House'));
      await mockRepository.saveDecision(const Decision(title: 'Sell Stock'));

      await cubit.setSearchTerm('Buy');

      expect(cubit.state.searchTerm, 'Buy');
      expect(cubit.state.decisions.length, 2);
    });

    test('setSearchTerm should trim whitespace', () async {
      await mockRepository.saveDecision(const Decision(title: 'Test'));

      await cubit.setSearchTerm('  Test  ');

      expect(cubit.state.searchTerm, 'Test');
    });

    test('setSearchTerm should reload when term changes', () async {
      await mockRepository.saveDecision(const Decision(title: 'Decision 1'));
      await cubit.load();

      await cubit.setSearchTerm('New Search');

      expect(cubit.state.page, 0);
    });

    test('setSearchTerm should not reload when term is same', () async {
      await cubit.setSearchTerm('Test');
      final stateBefore = cubit.state;

      await cubit.setSearchTerm('Test');
      final stateAfter = cubit.state;

      expect(stateAfter.page, stateBefore.page);
    });
  });
}
