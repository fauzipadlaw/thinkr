import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/decision.dart';

part 'decision_editor_state.freezed.dart';

@freezed
abstract class DecisionEditorState with _$DecisionEditorState {
  const factory DecisionEditorState({
    Decision? decision,

    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isEvaluated,

    String? errorMessage,
  }) = _DecisionEditorState;

  static const initial = DecisionEditorState();
}
