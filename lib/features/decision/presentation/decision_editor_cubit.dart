import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:thinkr/features/decision/domain/usecases/evaluate_decision_usecase.dart';
import 'package:thinkr/features/decision/domain/usecases/save_decision_usecase.dart';
import 'package:thinkr/features/decision/presentation/decision_editor_state.dart';

import '../domain/entities/decision.dart';

@lazySingleton
abstract class DecisionEditorCubit
    extends StateStreamableSource<DecisionEditorState> {
  @factoryMethod
  factory DecisionEditorCubit(
    EvaluateDecisionUseCase evaluateDecisionUseCase,
    SaveDecisionUseCase saveDecisionUseCase,
  ) = _DecisionEditorCubitImpl;

  void startNew({String title});
  void loadExisting(Decision decision);
  void setTitle(String title);
  void setDescription(String description);
  void setMethod(DecisionMethod method);

  void addOption(String label);
  void removeOption(OptionId id);
  void renameOption(OptionId id, String label);

  void addCriterion(String label, {double weight});
  void removeCriterion(CriterionId id);
  void setCriterionWeight(CriterionId id, double weight);
  void renameCriterion(CriterionId id, String label);

  void updateOptionDraft(String value);
  void updateCriterionDraft(String value);
  void updateCriterionWeightDraft(double value);
  void addDraftOption();
  void addDraftCriterion();

  void setScore({
    required OptionId optionId,
    required CriterionId criterionId,
    required double score,
  });

  void applyTemplate(Decision decision);

  Future<void> evaluate();
  Future<void> save({String? fallbackTitle});
}

class _DecisionEditorCubitImpl extends Cubit<DecisionEditorState>
    implements DecisionEditorCubit {
  final EvaluateDecisionUseCase _evaluate;
  final SaveDecisionUseCase _save;
  final _rng = Random();

  _DecisionEditorCubitImpl(this._evaluate, this._save)
    : super(DecisionEditorState.initial);

  String _newId() {
    final time = DateTime.now().microsecondsSinceEpoch;
    final rand = _rng.nextInt(1 << 32);
    return '$time-$rand';
  }

  Decision _ensureDecision() {
    final decision = state.decision ?? Decision.empty;
    return decision;
  }

  int _missingScores(Decision decision) {
    final expected = decision.options.length * decision.criteria.length;
    final actual = decision.scores.length;
    return max(0, expected - actual);
  }

  void _emitWithDecision(
    Decision decision, {
    bool? isLoading,
    bool? isSaving,
    bool? isEvaluated,
    bool? isDirty,
    String? errorMessage,
    String? optionDraft,
    String? criterionDraft,
    double? criterionWeightDraft,
  }) {
    final missingScores = _missingScores(decision);
    final hasMinOptions = decision.options.length >= 2;
    final hasCriteria = decision.criteria.isNotEmpty;
    final expectedScores = decision.options.length * decision.criteria.length;
    final completionPercent = expectedScores == 0
        ? 0
        : ((decision.scores.length / expectedScores) * 100)
              .clamp(0, 100)
              .round();

    emit(
      state.copyWith(
        decision: decision,
        isLoading: isLoading ?? state.isLoading,
        isSaving: isSaving ?? state.isSaving,
        isEvaluated: isEvaluated ?? state.isEvaluated,
        isDirty: isDirty ?? state.isDirty,
        errorMessage: errorMessage,
        missingScores: missingScores,
        hasMinOptions: hasMinOptions,
        hasCriteria: hasCriteria,
        canEvaluate: hasMinOptions && hasCriteria,
        completionPercent: completionPercent,
        optionDraft: optionDraft ?? state.optionDraft,
        criterionDraft: criterionDraft ?? state.criterionDraft,
        criterionWeightDraft:
            criterionWeightDraft ?? state.criterionWeightDraft,
      ),
    );
  }

  @override
  void startNew({String title = ''}) {
    final decision = Decision(
      title: title,
      method: DecisionMethod.weightedSum,
      options: const [],
      criteria: const [],
      scores: const {},
    );
    _emitWithDecision(
      decision,
      isLoading: false,
      isSaving: false,
      isEvaluated: false,
      isDirty: false,
      errorMessage: null,
      optionDraft: '',
      criterionDraft: '',
      criterionWeightDraft: 1.0,
    );
  }

  @override
  void loadExisting(Decision decision) {
    _emitWithDecision(
      decision,
      isLoading: false,
      isSaving: false,
      isEvaluated: decision.result != null,
      isDirty: false,
      errorMessage: null,
      optionDraft: '',
      criterionDraft: '',
      criterionWeightDraft: 1.0,
    );
  }

  @override
  void applyTemplate(Decision decision) {
    final newDecision = decision.copyWith(
      id: null,
      createdAt: null,
      updatedAt: null,
      deletedAt: null,
      scores: const {},
      result: null,
      options: decision.options
          .map((o) => o.copyWith(id: _newId()))
          .toList(growable: false),
      criteria: decision.criteria
          .map((c) => c.copyWith(id: _newId()))
          .toList(growable: false),
    );

    _emitWithDecision(
      newDecision,
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
      optionDraft: '',
      criterionDraft: '',
      criterionWeightDraft: 1.0,
    );
  }

  @override
  void setTitle(String title) {
    final d = _ensureDecision();
    _emitWithDecision(
      d.copyWith(title: title),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void setMethod(DecisionMethod method) {
    final d = _ensureDecision();
    _emitWithDecision(
      d.copyWith(method: method),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void setDescription(String description) {
    final d = _ensureDecision();
    _emitWithDecision(
      d.copyWith(description: description),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void addOption(String label) {
    final d = _ensureDecision();
    final id = _newId();
    final option = DecisionOption(id: id, label: label);

    _emitWithDecision(
      d.copyWith(options: [...d.options, option]),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void renameOption(OptionId id, String label) {
    final d = _ensureDecision();
    final updated = d.options
        .map((o) => o.id == id ? o.copyWith(label: label) : o)
        .toList();

    _emitWithDecision(
      d.copyWith(options: updated),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void removeOption(OptionId id) {
    final d = _ensureDecision();

    final newOptions = d.options.where((o) => o.id != id).toList();

    // Remove all scores for this option
    final newScores = Map<ScoreKey, double>.from(d.scores)
      ..removeWhere((key, _) => key.startsWith('$id|'));

    _emitWithDecision(
      d.copyWith(options: newOptions, scores: newScores),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void addCriterion(String label, {double weight = 1.0}) {
    final d = _ensureDecision();
    final id = _newId();
    final criterion = DecisionCriterion(id: id, label: label, weight: weight);

    _emitWithDecision(
      d.copyWith(criteria: [...d.criteria, criterion]),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void removeCriterion(CriterionId id) {
    final d = _ensureDecision();

    final newCriteria = d.criteria.where((c) => c.id != id).toList();

    // Remove scores related to this criterion
    final newScores = Map<ScoreKey, double>.from(d.scores)
      ..removeWhere((key, _) => key.split('|').last == id);

    _emitWithDecision(
      d.copyWith(criteria: newCriteria, scores: newScores),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void renameCriterion(CriterionId id, String label) {
    final d = _ensureDecision();
    final updated = d.criteria
        .map((c) => c.id == id ? c.copyWith(label: label) : c)
        .toList();

    _emitWithDecision(
      d.copyWith(criteria: updated),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void setCriterionWeight(CriterionId id, double weight) {
    final d = _ensureDecision();

    final updatedCriteria = d.criteria
        .map((c) => c.id == id ? c.copyWith(weight: weight) : c)
        .toList();

    _emitWithDecision(
      d.copyWith(criteria: updatedCriteria),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void updateOptionDraft(String value) {
    _emitWithDecision(
      _ensureDecision(),
      optionDraft: value,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void updateCriterionDraft(String value) {
    _emitWithDecision(
      _ensureDecision(),
      criterionDraft: value,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void updateCriterionWeightDraft(double value) {
    _emitWithDecision(
      _ensureDecision(),
      criterionWeightDraft: value,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  void addDraftOption() {
    final label = state.optionDraft.trim();
    if (label.isEmpty) return;

    final d = _ensureDecision();
    final id = _newId();
    final option = DecisionOption(id: id, label: label);

    _emitWithDecision(
      d.copyWith(options: [...d.options, option]),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
      optionDraft: '',
    );
  }

  @override
  void addDraftCriterion() {
    final label = state.criterionDraft.trim();
    if (label.isEmpty) return;

    final d = _ensureDecision();
    final id = _newId();
    final criterion = DecisionCriterion(
      id: id,
      label: label,
      weight: state.criterionWeightDraft,
    );

    _emitWithDecision(
      d.copyWith(criteria: [...d.criteria, criterion]),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
      criterionDraft: '',
      criterionWeightDraft: 1.0,
    );
  }

  @override
  void setScore({
    required OptionId optionId,
    required CriterionId criterionId,
    required double score,
  }) {
    final d = _ensureDecision();
    final key = '$optionId|$criterionId';

    final newScores = Map<ScoreKey, double>.from(d.scores)..[key] = score;

    _emitWithDecision(
      d.copyWith(scores: newScores),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
    );
  }

  @override
  Future<void> evaluate() async {
    try {
      final d = _ensureDecision();
      _emitWithDecision(d, isLoading: true, isSaving: true, errorMessage: null);

      final result = await _evaluate(d);
      final evaluated = d.copyWith(result: result);

      final saved = await _save(evaluated);

      _emitWithDecision(
        saved,
        isEvaluated: true,
        isLoading: false,
        isSaving: false,
        isDirty: false,
        errorMessage: null,
      );
    } catch (e) {
      _emitWithDecision(
        _ensureDecision(),
        isLoading: false,
        isEvaluated: false,
        isSaving: false,
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<void> save({String? fallbackTitle}) async {
    try {
      var d = _ensureDecision();
      if (fallbackTitle != null && d.title.trim().isEmpty) {
        d = d.copyWith(title: fallbackTitle);
      }
      _emitWithDecision(d, isSaving: true, errorMessage: null);

      final saved = await _save(d);

      _emitWithDecision(
        saved,
        isSaving: false,
        isDirty: false,
        errorMessage: null,
      );
    } catch (e) {
      _emitWithDecision(
        _ensureDecision(),
        isSaving: false,
        errorMessage: e.toString(),
      );
    }
  }
}
