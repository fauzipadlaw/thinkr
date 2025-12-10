import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:thinkr/features/decision/domain/usecases/evaluate_decision_usecase.dart';
import 'package:thinkr/features/decision/domain/usecases/save_decision_usecase.dart';
import 'package:thinkr/features/decision/presentation/decision_editor_state.dart';
import 'package:uuid/uuid.dart';

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
  void setScoreFromInput({
    required OptionId optionId,
    required CriterionId criterionId,
    required String raw,
    required String invalidMessage,
  });
  void setStep(int step, int maxSteps);
  void setAhpComparison({
    required CriterionId first,
    required CriterionId second,
    required double value,
  });
  void setFuzzySpread(double spread);

  void applyTemplate(Decision decision);

  Future<void> evaluate();
  Future<void> save({String? fallbackTitle});
}

class _DecisionEditorCubitImpl extends Cubit<DecisionEditorState>
    implements DecisionEditorCubit {
  final EvaluateDecisionUseCase _evaluate;
  final SaveDecisionUseCase _save;
  final _uuid = Uuid();

  _DecisionEditorCubitImpl(this._evaluate, this._save)
    : super(DecisionEditorState.initial);

  String _newId() => _uuid.v4();

  Decision _ensureDecision() {
    final decision = state.decision ?? Decision.empty;
    return decision;
  }

  Decision _syncAhpMatrix(Decision decision) {
    if (decision.method != DecisionMethod.ahp || decision.criteria.isEmpty) {
      return decision.copyWith(ahpMatrix: null);
    }

    double closestAhpStep(double value) {
      const levels = [1.0, 3.0, 5.0, 1 / 3, 1 / 5];
      var closest = levels.first;
      var minDiff = (value - closest).abs();
      for (final level in levels.skip(1)) {
        final diff = (value - level).abs();
        if (diff < minDiff) {
          minDiff = diff;
          closest = level;
        }
      }
      return closest;
    }

    final n = decision.criteria.length;
    final existing = decision.ahpMatrix;
    final matrix = List.generate(
      n,
      (i) =>
          List<double>.generate(n, (j) => i == j ? 1.0 : 1.0, growable: false),
      growable: false,
    );

    if (existing != null) {
      for (var i = 0; i < n; i++) {
        for (var j = 0; j < n; j++) {
          if (i == j) continue;
          if (i < existing.length && j < existing[i].length) {
            matrix[i][j] = existing[i][j];
          }
        }
      }
    }

    for (var i = 0; i < n; i++) {
      for (var j = 0; j < n; j++) {
        if (i == j) {
          matrix[i][j] = 1.0;
        } else {
          final forward = matrix[i][j];
          final reverse = matrix[j][i];
          if (forward != 0 && reverse == 1.0) {
            matrix[j][i] = 1 / forward;
          } else if (reverse != 0 && forward == 1.0) {
            matrix[i][j] = 1 / reverse;
          }
        }
      }
    }

    for (var i = 0; i < n; i++) {
      for (var j = 0; j < n; j++) {
        if (i == j) {
          matrix[i][j] = 1.0;
          continue;
        }
        final snapped = closestAhpStep(matrix[i][j]);
        matrix[i][j] = snapped;
        matrix[j][i] = 1 / snapped;
      }
    }

    return decision.copyWith(ahpMatrix: matrix);
  }

  bool _isAhpComplete(Decision decision) {
    final matrix = decision.ahpMatrix;
    final n = decision.criteria.length;
    if (matrix == null || matrix.length != n) return false;
    for (var i = 0; i < n; i++) {
      if (matrix[i].length != n) return false;
    }
    // Require at least one non-identity comparison.
    for (var i = 0; i < n; i++) {
      for (var j = 0; j < n; j++) {
        if (i == j) continue;
        if ((matrix[i][j] - 1).abs() > 0.001) {
          return true;
        }
      }
    }
    return false;
  }

  bool _methodReady(Decision decision, int missingScores) {
    if (missingScores > 0) return false;
    switch (decision.method) {
      case DecisionMethod.weightedSum:
        return true;
      case DecisionMethod.ahp:
        return _isAhpComplete(decision);
      case DecisionMethod.fuzzyWeightedSum:
        return (decision.fuzzySpread ?? 0) > 0;
    }
  }

  Decision _prepareForEvaluation(Decision d) {
    if (d.method == DecisionMethod.ahp) {
      final synced = _syncAhpMatrix(d);
      if (!_isAhpComplete(synced)) {
        throw StateError('Provide pairwise AHP comparisons before evaluating.');
      }
      return synced;
    }
    if (d.method == DecisionMethod.fuzzyWeightedSum) {
      if (d.fuzzySpread == null || d.fuzzySpread! <= 0) {
        throw StateError('Provide fuzzy spread before evaluating.');
      }
      return d;
    }
    return d;
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
    int? currentStep,
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

    final adjustedDecision = decision.method == DecisionMethod.ahp
        ? _syncAhpMatrix(decision)
        : decision;
    final methodReady = _methodReady(adjustedDecision, missingScores);

    emit(
      state.copyWith(
        decision: adjustedDecision,
        isLoading: isLoading ?? state.isLoading,
        isSaving: isSaving ?? state.isSaving,
        isEvaluated: isEvaluated ?? state.isEvaluated,
        isDirty: isDirty ?? state.isDirty,
        currentStep: currentStep ?? state.currentStep,
        errorMessage: errorMessage,
        missingScores: missingScores,
        hasMinOptions: hasMinOptions,
        hasCriteria: hasCriteria,
        canEvaluate: hasMinOptions && hasCriteria && methodReady,
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
      currentStep: state.currentStep,
    );
  }

  @override
  void setMethod(DecisionMethod method) {
    final d = _ensureDecision();
    _emitWithDecision(
      d.copyWith(
        method: method,
        ahpMatrix: method == DecisionMethod.ahp ? d.ahpMatrix : null,
        fuzzySpread: method == DecisionMethod.fuzzyWeightedSum
            ? (d.fuzzySpread ?? 1.0)
            : null,
      ),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
      currentStep: state.currentStep,
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
      currentStep: state.currentStep,
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
      currentStep: state.currentStep,
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
      currentStep: state.currentStep,
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
      currentStep: state.currentStep,
    );
  }

  @override
  void addCriterion(String label, {double weight = 1.0}) {
    final d = _ensureDecision();
    final id = _newId();
    final criterion = DecisionCriterion(
      id: id,
      label: label,
      weight: weight.clamp(0.1, 10),
    );

    _emitWithDecision(
      d.copyWith(criteria: [...d.criteria, criterion], ahpMatrix: null),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
      currentStep: state.currentStep,
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
      d.copyWith(criteria: newCriteria, scores: newScores, ahpMatrix: null),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
      currentStep: state.currentStep,
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
      currentStep: state.currentStep,
    );
  }

  @override
  void setCriterionWeight(CriterionId id, double weight) {
    final d = _ensureDecision();

    final updatedCriteria = d.criteria
        .map((c) => c.id == id ? c.copyWith(weight: weight.clamp(0.1, 10)) : c)
        .toList();

    _emitWithDecision(
      d.copyWith(criteria: updatedCriteria),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
      currentStep: state.currentStep,
    );
  }

  @override
  void updateOptionDraft(String value) {
    _emitWithDecision(
      _ensureDecision(),
      optionDraft: value,
      isDirty: true,
      errorMessage: null,
      currentStep: state.currentStep,
    );
  }

  @override
  void updateCriterionDraft(String value) {
    _emitWithDecision(
      _ensureDecision(),
      criterionDraft: value,
      isDirty: true,
      errorMessage: null,
      currentStep: state.currentStep,
    );
  }

  @override
  void updateCriterionWeightDraft(double value) {
    _emitWithDecision(
      _ensureDecision(),
      criterionWeightDraft: value,
      isDirty: true,
      errorMessage: null,
      currentStep: state.currentStep,
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
      currentStep: state.currentStep,
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
      weight: state.criterionWeightDraft.clamp(0.1, 10),
    );

    _emitWithDecision(
      d.copyWith(criteria: [...d.criteria, criterion], ahpMatrix: null),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
      criterionDraft: '',
      criterionWeightDraft: 1.0,
      currentStep: state.currentStep,
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

    final bounded = score.clamp(1, 10).toDouble();
    final newScores = Map<ScoreKey, double>.from(d.scores)..[key] = bounded;

    _emitWithDecision(
      d.copyWith(scores: newScores),
      isEvaluated: false,
      isDirty: true,
      errorMessage: null,
      currentStep: state.currentStep,
    );
  }

  @override
  void setScoreFromInput({
    required OptionId optionId,
    required CriterionId criterionId,
    required String raw,
    required String invalidMessage,
  }) {
    final parsed = double.tryParse(raw);
    if (parsed == null) return;
    if (parsed < 1 || parsed > 10) {
      _emitWithDecision(_ensureDecision(), errorMessage: invalidMessage);
      return;
    }
    setScore(optionId: optionId, criterionId: criterionId, score: parsed);
  }

  @override
  void setAhpComparison({
    required CriterionId first,
    required CriterionId second,
    required double value,
  }) {
    final d = _ensureDecision();
    if (d.criteria.length < 2) return;
    final matrix = _syncAhpMatrix(d).ahpMatrix!;
    final indexMap = {
      for (var i = 0; i < d.criteria.length; i++) d.criteria[i].id: i,
    };
    final i = indexMap[first];
    final j = indexMap[second];
    if (i == null || j == null || i == j) return;
    matrix[i][j] = value;
    matrix[j][i] = 1 / value;
    _emitWithDecision(
      d.copyWith(ahpMatrix: matrix),
      isDirty: true,
      isEvaluated: false,
      currentStep: state.currentStep,
    );
  }

  @override
  void setFuzzySpread(double spread) {
    final d = _ensureDecision();
    _emitWithDecision(
      d.copyWith(fuzzySpread: spread.clamp(0.01, 100)),
      isDirty: true,
      isEvaluated: false,
      currentStep: state.currentStep,
    );
  }

  @override
  void setStep(int step, int maxSteps) {
    final upper = maxSteps > 0 ? maxSteps - 1 : 0;
    final clamped = step.clamp(0, upper);
    emit(state.copyWith(currentStep: clamped));
  }

  @override
  Future<void> evaluate() async {
    try {
      final base = _ensureDecision();
      final missingScores = _missingScores(base);
      if (!_methodReady(base, missingScores)) {
        throw StateError(
          'Complete all required inputs for this method before evaluating.',
        );
      }
      final prepared = _prepareForEvaluation(base);
      _emitWithDecision(
        prepared,
        isLoading: true,
        isSaving: true,
        errorMessage: null,
      );

      final result = await _evaluate(prepared);
      final evaluated = prepared.copyWith(result: result);

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
      var d = _prepareForEvaluation(_ensureDecision());
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
