import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';

part 'decision_history_state.freezed.dart';

@freezed
abstract class DecisionHistoryState with _$DecisionHistoryState {
  const factory DecisionHistoryState({
    @Default([]) List<Decision> decisions,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isDeleting,
    @Default(true) bool hasMore,
    @Default(0) int page,
    @Default('') String searchTerm,
    String? errorMessage,
  }) = _DecisionHistoryState;

  static const initial = DecisionHistoryState();
}
