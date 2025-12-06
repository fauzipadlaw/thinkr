import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/decision.dart';
import '../../domain/usecases/get_decision_history_usecase.dart';

@lazySingleton
abstract class DecisionPreviewCubit
    extends StateStreamableSource<DecisionPreviewState> {
  @factoryMethod
  factory DecisionPreviewCubit(GetDecisionHistoryUseCase getHistory) =
      _DecisionPreviewCubitImpl;

  Future<void> load();
  Future<void> refresh();
}

class DecisionPreviewState {
  final List<Decision> decisions;
  final bool isLoading;
  final String? errorMessage;

  const DecisionPreviewState({
    required this.decisions,
    required this.isLoading,
    this.errorMessage,
  });

  static const initial = DecisionPreviewState(
    decisions: [],
    isLoading: false,
    errorMessage: null,
  );

  DecisionPreviewState copyWith({
    List<Decision>? decisions,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DecisionPreviewState(
      decisions: decisions ?? this.decisions,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class _DecisionPreviewCubitImpl extends Cubit<DecisionPreviewState>
    implements DecisionPreviewCubit {
  final GetDecisionHistoryUseCase _getHistory;
  static const int _limit = 3;

  _DecisionPreviewCubitImpl(this._getHistory)
    : super(DecisionPreviewState.initial);

  @override
  Future<void> load() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final decisions = await _getHistory(limit: _limit, offset: 0);
      emit(
        state.copyWith(
          decisions: decisions,
          isLoading: false,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> refresh() => load();
}
