import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/decision.dart';
import '../../domain/usecases/get_decision_history_usecase.dart';
import '../../domain/usecases/soft_delete_decision_usecase.dart';
import 'decision_history_state.dart';

@lazySingleton
abstract class DecisionHistoryCubit
    extends StateStreamableSource<DecisionHistoryState> {
  @factoryMethod
  factory DecisionHistoryCubit(
    GetDecisionHistoryUseCase getHistory,
    SoftDeleteDecisionUseCase softDelete,
  ) = _DecisionHistoryCubitImpl;

  Future<void> load();
  Future<void> refresh();
  Future<void> loadMore();
  Future<void> goToPage(int page);
  Future<void> delete(DecisionId id);
  Future<void> setSearchTerm(String term);
}

class _DecisionHistoryCubitImpl extends Cubit<DecisionHistoryState>
    implements DecisionHistoryCubit {
  static const int _pageSize = 10;
  final GetDecisionHistoryUseCase _getHistory;
  final SoftDeleteDecisionUseCase _softDelete;

  _DecisionHistoryCubitImpl(this._getHistory, this._softDelete)
      : super(DecisionHistoryState.initial);

  @override
  Future<void> load() async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        page: 0,
        hasMore: true,
      ),
    );
    try {
      final term = state.searchTerm.trim().isEmpty ? null : state.searchTerm;
      final decisions = await _getHistory(
        limit: _pageSize,
        offset: 0,
        query: term,
      );
      emit(
        state.copyWith(
          decisions: decisions,
          isLoading: false,
          hasMore: decisions.length == _pageSize,
          page: 0,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> refresh() => load();

  @override
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;
    emit(state.copyWith(isLoadingMore: true, errorMessage: null));
    try {
      final nextOffset = state.decisions.length;
      final term = state.searchTerm.trim().isEmpty ? null : state.searchTerm;
      final next = await _getHistory(
        limit: _pageSize,
        offset: nextOffset,
        query: term,
      );
      emit(
        state.copyWith(
          decisions: [...state.decisions, ...next],
          isLoadingMore: false,
          hasMore: next.length == _pageSize,
          page: state.page,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> goToPage(int page) async {
    if (page < 0) return;
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final offset = page * _pageSize;
      final term = state.searchTerm.trim().isEmpty ? null : state.searchTerm;
      final data = await _getHistory(
        limit: _pageSize,
        offset: offset,
        query: term,
      );
      emit(
        state.copyWith(
          decisions: data,
          isLoading: false,
          hasMore: data.length == _pageSize,
          page: page,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> delete(DecisionId id) async {
    emit(state.copyWith(isDeleting: true, errorMessage: null));
    try {
      await _softDelete(id);
      final updated = state.decisions.where((d) => d.id != id).toList();
      emit(
        state.copyWith(
          decisions: updated,
          isDeleting: false,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isDeleting: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> setSearchTerm(String term) async {
    final normalized = term.trim();
    if (normalized == state.searchTerm) return;
    emit(state.copyWith(searchTerm: normalized));
    await load();
  }
}
