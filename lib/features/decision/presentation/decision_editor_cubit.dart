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
  void setTitle(String title);

  void addOption(String label);
  void removeOption(OptionId id);

  void addCriterion(String label, {double weight});
  void removeCriterion(CriterionId id);
  void setCriterionWeight(CriterionId id, double weight);

  void setScore({
    required OptionId optionId,
    required CriterionId criterionId,
    required double score,
  });

  Future<void> evaluate();
  Future<void> save();
}

class _DecisionEditorCubitImpl extends Cubit<DecisionEditorState>
    implements DecisionEditorCubit {
  final EvaluateDecisionUseCase _evaluate;
  final SaveDecisionUseCase _save;

  _DecisionEditorCubitImpl(this._evaluate, this._save)
    : super(DecisionEditorState.initial);

  @override
  void startNew({String title = ''}) {
    emit(
      DecisionEditorState(
        decision: Decision(
          title: title,
          options: const [],
          criteria: const [],
          scores: const {},
        ),
        isLoading: false,
        isSaving: false,
        isEvaluated: false,
        errorMessage: null,
      ),
    );
  }

  Decision _ensureDecision() {
    final decision = state.decision ?? const Decision(title: '');
    return decision;
  }

  @override
  void setTitle(String title) {
    final d = _ensureDecision();
    emit(
      state.copyWith(
        decision: d.copyWith(title: title),
        isEvaluated: false,
        errorMessage: null,
      ),
    );
  }

  @override
  void addOption(String label) {
    final d = _ensureDecision();
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final option = DecisionOption(id: id, label: label);

    emit(
      state.copyWith(
        decision: d.copyWith(options: [...d.options, option]),
        isEvaluated: false,
        errorMessage: null,
      ),
    );
  }

  @override
  void removeOption(OptionId id) {
    final d = _ensureDecision();

    final newOptions = d.options.where((o) => o.id != id).toList();

    // Remove all scores for this option
    final newScores = Map<ScoreKey, double>.from(d.scores)
      ..removeWhere((key, _) => key.startsWith('$id|'));

    emit(
      state.copyWith(
        decision: d.copyWith(options: newOptions, scores: newScores),
        isEvaluated: false,
        errorMessage: null,
      ),
    );
  }

  @override
  void addCriterion(String label, {double weight = 1.0}) {
    final d = _ensureDecision();
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final criterion = DecisionCriterion(id: id, label: label, weight: weight);

    emit(
      state.copyWith(
        decision: d.copyWith(criteria: [...d.criteria, criterion]),
        isEvaluated: false,
        errorMessage: null,
      ),
    );
  }

  @override
  void removeCriterion(CriterionId id) {
    final d = _ensureDecision();

    final newCriteria = d.criteria.where((c) => c.id != id).toList();

    // Remove scores related to this criterion
    final newScores = Map<ScoreKey, double>.from(d.scores)
      ..removeWhere((key, _) => key.split('|').last == id);

    emit(
      state.copyWith(
        decision: d.copyWith(criteria: newCriteria, scores: newScores),
        isEvaluated: false,
        errorMessage: null,
      ),
    );
  }

  @override
  void setCriterionWeight(CriterionId id, double weight) {
    final d = _ensureDecision();

    final updatedCriteria = d.criteria
        .map((c) => c.id == id ? c.copyWith(weight: weight) : c)
        .toList();

    emit(
      state.copyWith(
        decision: d.copyWith(criteria: updatedCriteria),
        isEvaluated: false,
        errorMessage: null,
      ),
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

    emit(
      state.copyWith(
        decision: d.copyWith(scores: newScores),
        isEvaluated: false,
        errorMessage: null,
      ),
    );
  }

  @override
  Future<void> evaluate() async {
    try {
      final d = _ensureDecision();
      final result = _evaluate(d);

      emit(
        state.copyWith(
          decision: d.copyWith(result: result),
          isEvaluated: true,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isEvaluated: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> save() async {
    try {
      final d = _ensureDecision();
      emit(state.copyWith(isSaving: true, errorMessage: null));

      final saved = await _save(d);

      emit(
        state.copyWith(decision: saved, isSaving: false, errorMessage: null),
      );
    } catch (e) {
      emit(state.copyWith(isSaving: false, errorMessage: e.toString()));
    }
  }
}
