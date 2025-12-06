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
    @Default(false) bool isDirty,

    String? errorMessage,

    // Derived validation/status fields
    @Default(0) int missingScores,
    @Default(false) bool hasMinOptions,
    @Default(false) bool hasCriteria,
    @Default(false) bool canEvaluate,
    @Default(0) int completionPercent,

    // Draft inputs managed by the cubit
    @Default('') String optionDraft,
    @Default('') String criterionDraft,
    @Default(1.0) double criterionWeightDraft,
  }) = _DecisionEditorState;

  static const initial = DecisionEditorState();
}

extension DecisionEditorStateX on DecisionEditorState {
  bool get readyToSave => canEvaluate && !isSaving && !isLoading;
}
