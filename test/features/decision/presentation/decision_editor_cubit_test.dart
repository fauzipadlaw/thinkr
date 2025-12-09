import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';
import 'package:thinkr/features/decision/domain/usecases/evaluate_decision_usecase.dart';
import 'package:thinkr/features/decision/domain/usecases/save_decision_usecase.dart';
import 'package:thinkr/features/decision/presentation/decision_editor_cubit.dart';
import 'package:thinkr/features/decision/presentation/decision_editor_state.dart';
import '../../../helpers/mock_decision_repository.dart';

void main() {
  late MockDecisionRepository mockRepository;
  late EvaluateDecisionUseCase evaluateUseCase;
  late SaveDecisionUseCase saveUseCase;
  late DecisionEditorCubit cubit;

  setUp(() {
    mockRepository = MockDecisionRepository();
    evaluateUseCase = EvaluateDecisionUseCase(mockRepository);
    saveUseCase = SaveDecisionUseCase(mockRepository);
    cubit = DecisionEditorCubit(evaluateUseCase, saveUseCase);
  });

  tearDown(() {
    cubit.close();
    mockRepository.clear();
  });

  group('DecisionEditorCubit - Initialization', () {
    test('initial state should be empty', () {
      expect(cubit.state, equals(DecisionEditorState.initial));
      expect(cubit.state.decision, isNull);
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.isSaving, isFalse);
      expect(cubit.state.isEvaluated, isFalse);
      expect(cubit.state.isDirty, isFalse);
      expect(cubit.state.canEvaluate, isFalse);
    });

    test('startNew should create empty decision with default method', () {
      cubit.startNew();

      expect(cubit.state.decision, isNotNull);
      expect(cubit.state.decision!.title, isEmpty);
      expect(cubit.state.decision!.method, DecisionMethod.weightedSum);
      expect(cubit.state.decision!.options, isEmpty);
      expect(cubit.state.decision!.criteria, isEmpty);
      expect(cubit.state.isDirty, isFalse);
      expect(cubit.state.isEvaluated, isFalse);
    });

    test('startNew should accept custom title', () {
      cubit.startNew(title: 'Custom Decision');

      expect(cubit.state.decision!.title, 'Custom Decision');
    });

    test('loadExisting should load decision and preserve evaluation state', () {
      final decision = Decision(
        id: 'existing-1',
        title: 'Existing Decision',
        method: DecisionMethod.ahp,
        options: const [DecisionOption(id: 'opt-1', label: 'Option 1')],
        criteria: const [
          DecisionCriterion(id: 'crit-1', label: 'Criterion 1', weight: 2.0),
        ],
        scores: const {'opt-1|crit-1': 8.0},
        ahpMatrix: const [
          [1.0],
        ], // Add this line
        result: const DecisionResult(
          bestOptionId: 'opt-1',
          scores: {'opt-1': 8.0},
          ranking: ['opt-1'],
        ),
      );

      cubit.loadExisting(decision);

      expect(cubit.state.decision, equals(decision));
      expect(cubit.state.isEvaluated, isTrue);
      expect(cubit.state.isDirty, isFalse);
    });
  });

  group('DecisionEditorCubit - Basic Properties', () {
    test('setTitle should update title and set dirty flag', () {
      cubit.startNew();
      cubit.setTitle('New Title');

      expect(cubit.state.decision!.title, 'New Title');
      expect(cubit.state.isDirty, isTrue);
      expect(cubit.state.isEvaluated, isFalse);
    });

    test('setDescription should update description and set dirty flag', () {
      cubit.startNew();
      cubit.setDescription('Detailed description');

      expect(cubit.state.decision!.description, 'Detailed description');
      expect(cubit.state.isDirty, isTrue);
      expect(cubit.state.isEvaluated, isFalse);
    });

    test('setMethod should update method', () {
      cubit.startNew();

      cubit.setMethod(DecisionMethod.ahp);
      expect(cubit.state.decision!.method, DecisionMethod.ahp);

      cubit.setMethod(DecisionMethod.fuzzyWeightedSum);
      expect(cubit.state.decision!.method, DecisionMethod.fuzzyWeightedSum);
      expect(cubit.state.decision!.fuzzySpread, isNotNull);

      cubit.setMethod(DecisionMethod.weightedSum);
      expect(cubit.state.decision!.method, DecisionMethod.weightedSum);
    });

    test('setMethod should clear ahpMatrix when switching from AHP', () {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.ahp);
      cubit.addCriterion('Criterion 1');
      cubit.addCriterion('Criterion 2');

      // AHP matrix should exist
      expect(cubit.state.decision!.ahpMatrix, isNotNull);

      cubit.setMethod(DecisionMethod.weightedSum);
      expect(cubit.state.decision!.ahpMatrix, isNull);
    });
  });

  group('DecisionEditorCubit - Options Management', () {
    test('addOption should add option to decision', () {
      cubit.startNew();
      cubit.addOption('Option 1');

      expect(cubit.state.decision!.options.length, 1);
      expect(cubit.state.decision!.options.first.label, 'Option 1');
      expect(cubit.state.decision!.options.first.id, isNotEmpty);
      expect(cubit.state.isDirty, isTrue);
    });

    test('addOption should generate unique IDs for each option', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');

      final ids = cubit.state.decision!.options.map((o) => o.id).toList();
      expect(ids.toSet().length, 2);
    });

    test('renameOption should update option label', () {
      cubit.startNew();
      cubit.addOption('Original Name');

      final optionId = cubit.state.decision!.options.first.id;
      cubit.renameOption(optionId, 'Updated Name');

      expect(cubit.state.decision!.options.first.label, 'Updated Name');
      expect(cubit.state.isDirty, isTrue);
    });

    test('removeOption should remove option and associated scores', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Criterion 1');

      final optionId = cubit.state.decision!.options.first.id;
      final criterionId = cubit.state.decision!.criteria.first.id;
      cubit.setScore(optionId: optionId, criterionId: criterionId, score: 7.5);

      expect(cubit.state.decision!.options.length, 2);
      expect(cubit.state.decision!.scores.length, 1);

      cubit.removeOption(optionId);

      expect(cubit.state.decision!.options.length, 1);
      expect(cubit.state.decision!.scores.length, 0);
    });

    test('updateOptionDraft should update draft value', () {
      cubit.startNew();
      cubit.updateOptionDraft('Draft Option');

      expect(cubit.state.optionDraft, 'Draft Option');
    });

    test('addDraftOption should add option from draft and clear draft', () {
      cubit.startNew();
      cubit.updateOptionDraft('New Option');
      cubit.addDraftOption();

      expect(cubit.state.decision!.options.length, 1);
      expect(cubit.state.decision!.options.first.label, 'New Option');
      expect(cubit.state.optionDraft, isEmpty);
    });

    test('addDraftOption should trim whitespace', () {
      cubit.startNew();
      cubit.updateOptionDraft('  Spaced Option  ');
      cubit.addDraftOption();

      expect(cubit.state.decision!.options.first.label, 'Spaced Option');
    });

    test('addDraftOption should ignore empty draft', () {
      cubit.startNew();
      cubit.updateOptionDraft('   ');
      cubit.addDraftOption();

      expect(cubit.state.decision!.options.length, 0);
    });
  });

  group('DecisionEditorCubit - Criteria Management', () {
    test('addCriterion should add criterion with default weight', () {
      cubit.startNew();
      cubit.addCriterion('Quality');

      expect(cubit.state.decision!.criteria.length, 1);
      expect(cubit.state.decision!.criteria.first.label, 'Quality');
      expect(cubit.state.decision!.criteria.first.weight, 1.0);
    });

    test('addCriterion should accept custom weight', () {
      cubit.startNew();
      cubit.addCriterion('Cost', weight: 5.0);

      expect(cubit.state.decision!.criteria.first.weight, 5.0);
    });

    test('addCriterion should clamp weight to valid range', () {
      cubit.startNew();
      cubit.addCriterion('Too Low', weight: 0.05);
      expect(cubit.state.decision!.criteria.first.weight, 0.1);

      cubit.addCriterion('Too High', weight: 15.0);
      expect(cubit.state.decision!.criteria.last.weight, 10.0);
    });

    test('renameCriterion should update criterion label', () {
      cubit.startNew();
      cubit.addCriterion('Original');

      final criterionId = cubit.state.decision!.criteria.first.id;
      cubit.renameCriterion(criterionId, 'Updated');

      expect(cubit.state.decision!.criteria.first.label, 'Updated');
    });

    test('setCriterionWeight should update weight within valid range', () {
      cubit.startNew();
      cubit.addCriterion('Criterion');

      final criterionId = cubit.state.decision!.criteria.first.id;
      cubit.setCriterionWeight(criterionId, 3.5);

      expect(cubit.state.decision!.criteria.first.weight, 3.5);
    });

    test('setCriterionWeight should clamp to valid range', () {
      cubit.startNew();
      cubit.addCriterion('Criterion');

      final criterionId = cubit.state.decision!.criteria.first.id;

      cubit.setCriterionWeight(criterionId, 0.05);
      expect(cubit.state.decision!.criteria.first.weight, 0.1);

      cubit.setCriterionWeight(criterionId, 20.0);
      expect(cubit.state.decision!.criteria.first.weight, 10.0);
    });

    test('removeCriterion should remove criterion and associated scores', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');
      cubit.addCriterion('Criterion 2');

      final optionId = cubit.state.decision!.options.first.id;
      final criterion1Id = cubit.state.decision!.criteria.first.id;
      cubit.setScore(optionId: optionId, criterionId: criterion1Id, score: 8.0);

      expect(cubit.state.decision!.criteria.length, 2);
      expect(cubit.state.decision!.scores.length, 1);

      cubit.removeCriterion(criterion1Id);

      expect(cubit.state.decision!.criteria.length, 1);
      expect(cubit.state.decision!.scores.length, 0);
    });

    test('updateCriterionDraft should update draft value', () {
      cubit.startNew();
      cubit.updateCriterionDraft('Draft Criterion');

      expect(cubit.state.criterionDraft, 'Draft Criterion');
    });

    test('updateCriterionWeightDraft should update weight draft', () {
      cubit.startNew();
      cubit.updateCriterionWeightDraft(4.5);

      expect(cubit.state.criterionWeightDraft, 4.5);
    });

    test('addDraftCriterion should add criterion from draft', () {
      cubit.startNew();
      cubit.updateCriterionDraft('New Criterion');
      cubit.updateCriterionWeightDraft(2.5);
      cubit.addDraftCriterion();

      expect(cubit.state.decision!.criteria.length, 1);
      expect(cubit.state.decision!.criteria.first.label, 'New Criterion');
      expect(cubit.state.decision!.criteria.first.weight, 2.5);
      expect(cubit.state.criterionDraft, isEmpty);
      expect(cubit.state.criterionWeightDraft, 1.0);
    });

    test('addDraftCriterion should ignore empty draft', () {
      cubit.startNew();
      cubit.updateCriterionDraft('   ');
      cubit.addDraftCriterion();

      expect(cubit.state.decision!.criteria.length, 0);
    });
  });

  group('DecisionEditorCubit - Score Management', () {
    test('setScore should set score for option-criterion pair', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');

      final optionId = cubit.state.decision!.options.first.id;
      final criterionId = cubit.state.decision!.criteria.first.id;

      cubit.setScore(optionId: optionId, criterionId: criterionId, score: 7.5);

      final key = '$optionId|$criterionId';
      expect(cubit.state.decision!.scores[key], 7.5);
      expect(cubit.state.isDirty, isTrue);
      expect(cubit.state.isEvaluated, isFalse);
    });

    test('setScore should clamp score to valid range (1-10)', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');

      final optionId = cubit.state.decision!.options.first.id;
      final criterionId = cubit.state.decision!.criteria.first.id;

      cubit.setScore(optionId: optionId, criterionId: criterionId, score: 0.5);
      expect(cubit.state.decision!.scores['$optionId|$criterionId'], 1.0);

      cubit.setScore(optionId: optionId, criterionId: criterionId, score: 15.0);
      expect(cubit.state.decision!.scores['$optionId|$criterionId'], 10.0);
    });

    test('setScoreFromInput should parse and set valid score', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');

      final optionId = cubit.state.decision!.options.first.id;
      final criterionId = cubit.state.decision!.criteria.first.id;

      cubit.setScoreFromInput(
        optionId: optionId,
        criterionId: criterionId,
        raw: '8.5',
        invalidMessage: 'Invalid score',
      );

      expect(cubit.state.decision!.scores['$optionId|$criterionId'], 8.5);
    });

    test('setScoreFromInput should reject invalid numeric input', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');

      final optionId = cubit.state.decision!.options.first.id;
      final criterionId = cubit.state.decision!.criteria.first.id;

      cubit.setScoreFromInput(
        optionId: optionId,
        criterionId: criterionId,
        raw: 'not-a-number',
        invalidMessage: 'Invalid score',
      );

      expect(cubit.state.decision!.scores.length, 0);
    });

    test('setScoreFromInput should reject out-of-range values', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');

      final optionId = cubit.state.decision!.options.first.id;
      final criterionId = cubit.state.decision!.criteria.first.id;

      cubit.setScoreFromInput(
        optionId: optionId,
        criterionId: criterionId,
        raw: '15',
        invalidMessage: 'Score must be between 1 and 10',
      );

      expect(cubit.state.errorMessage, 'Score must be between 1 and 10');
    });

    test('missingScores should be calculated correctly', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Criterion 1');

      expect(cubit.state.missingScores, 2);

      final option1Id = cubit.state.decision!.options[0].id;
      final criterionId = cubit.state.decision!.criteria.first.id;

      cubit.setScore(optionId: option1Id, criterionId: criterionId, score: 7.0);

      expect(cubit.state.missingScores, 1);
    });

    test('completionPercent should be calculated correctly', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Criterion 1');

      expect(cubit.state.completionPercent, 0);

      final option1Id = cubit.state.decision!.options[0].id;
      final criterionId = cubit.state.decision!.criteria.first.id;

      cubit.setScore(optionId: option1Id, criterionId: criterionId, score: 7.0);

      expect(cubit.state.completionPercent, 50);
    });
  });

  group('DecisionEditorCubit - AHP Method', () {
    test('AHP matrix should be created when switching to AHP method', () {
      cubit.startNew();
      cubit.addCriterion('Criterion 1');
      cubit.addCriterion('Criterion 2');

      cubit.setMethod(DecisionMethod.ahp);

      expect(cubit.state.decision!.ahpMatrix, isNotNull);
      expect(cubit.state.decision!.ahpMatrix!.length, 2);
    });

    test('setAhpComparison should update matrix symmetrically', () {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.ahp);
      cubit.addCriterion('Quality');
      cubit.addCriterion('Cost');

      final crit1Id = cubit.state.decision!.criteria[0].id;
      final crit2Id = cubit.state.decision!.criteria[1].id;

      cubit.setAhpComparison(first: crit1Id, second: crit2Id, value: 3.0);

      final matrix = cubit.state.decision!.ahpMatrix!;
      expect(matrix[0][1], 3.0);
      expect(matrix[1][0], closeTo(1 / 3.0, 0.001));
    });

    test('setAhpComparison should ensure diagonal is always 1.0', () {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.ahp);
      cubit.addCriterion('Quality');
      cubit.addCriterion('Cost');

      final matrix = cubit.state.decision!.ahpMatrix!;
      expect(matrix[0][0], 1.0);
      expect(matrix[1][1], 1.0);
    });

    test('setAhpComparison should ignore invalid indices', () {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.ahp);
      cubit.addCriterion('Criterion 1');

      final crit1Id = cubit.state.decision!.criteria.first.id;

      // Comparing criterion with itself should be ignored
      cubit.setAhpComparison(first: crit1Id, second: crit1Id, value: 5.0);

      final matrix = cubit.state.decision!.ahpMatrix!;
      expect(matrix[0][0], 1.0);
    });

    test('AHP matrix should expand when adding criteria', () {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.ahp);
      cubit.addCriterion('Criterion 1');

      expect(cubit.state.decision!.ahpMatrix!.length, 1);

      cubit.addCriterion('Criterion 2');
      expect(cubit.state.decision!.ahpMatrix!.length, 2);

      cubit.addCriterion('Criterion 3');
      expect(cubit.state.decision!.ahpMatrix!.length, 3);
    });

    test('canEvaluate should be false for AHP without comparisons', () {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.ahp);
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Criterion 1');
      cubit.addCriterion('Criterion 2');

      // Fill in all scores
      for (var option in cubit.state.decision!.options) {
        for (var criterion in cubit.state.decision!.criteria) {
          cubit.setScore(
            optionId: option.id,
            criterionId: criterion.id,
            score: 5.0,
          );
        }
      }

      expect(cubit.state.canEvaluate, isFalse);
    });

    test('canEvaluate should be true for AHP with valid comparisons', () {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.ahp);
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Quality');
      cubit.addCriterion('Cost');

      // Fill in scores
      for (var option in cubit.state.decision!.options) {
        for (var criterion in cubit.state.decision!.criteria) {
          cubit.setScore(
            optionId: option.id,
            criterionId: criterion.id,
            score: 5.0,
          );
        }
      }

      // Add AHP comparison
      final crit1Id = cubit.state.decision!.criteria[0].id;
      final crit2Id = cubit.state.decision!.criteria[1].id;
      cubit.setAhpComparison(first: crit1Id, second: crit2Id, value: 3.0);

      expect(cubit.state.canEvaluate, isTrue);
    });
  });

  group('DecisionEditorCubit - Fuzzy Method', () {
    test('setFuzzySpread should update spread value', () {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.fuzzyWeightedSum);
      cubit.setFuzzySpread(2.5);

      expect(cubit.state.decision!.fuzzySpread, 2.5);
    });

    test('setFuzzySpread should clamp to valid range', () {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.fuzzyWeightedSum);

      cubit.setFuzzySpread(0.005);
      expect(cubit.state.decision!.fuzzySpread, 0.01);

      cubit.setFuzzySpread(150.0);
      expect(cubit.state.decision!.fuzzySpread, 100.0);
    });

    test('canEvaluate should be false for fuzzy without spread', () {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.fuzzyWeightedSum);
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Criterion 1');

      for (var option in cubit.state.decision!.options) {
        for (var criterion in cubit.state.decision!.criteria) {
          cubit.setScore(
            optionId: option.id,
            criterionId: criterion.id,
            score: 5.0,
          );
        }
      }

      // Set invalid spread
      final decision = cubit.state.decision!.copyWith(fuzzySpread: 0);
      cubit.loadExisting(decision);

      expect(cubit.state.canEvaluate, isFalse);
    });
  });

  group('DecisionEditorCubit - Step Management', () {
    test('setStep should update current step', () {
      cubit.startNew();
      cubit.setStep(2, 5);

      expect(cubit.state.currentStep, 2);
    });

    test('setStep should clamp to valid range', () {
      cubit.startNew();

      cubit.setStep(-1, 5);
      expect(cubit.state.currentStep, 0);

      cubit.setStep(10, 5);
      expect(cubit.state.currentStep, 4);
    });

    test('setStep should handle zero maxSteps', () {
      cubit.startNew();
      cubit.setStep(5, 0);

      expect(cubit.state.currentStep, 0);
    });
  });

  group('DecisionEditorCubit - Template Application', () {
    test('applyTemplate should copy structure without scores', () {
      final template = Decision(
        id: 'template-1',
        title: 'Template Decision',
        method: DecisionMethod.weightedSum,
        options: const [
          DecisionOption(id: 'tmpl-opt-1', label: 'Template Option 1'),
          DecisionOption(id: 'tmpl-opt-2', label: 'Template Option 2'),
        ],
        criteria: const [
          DecisionCriterion(
            id: 'tmpl-crit-1',
            label: 'Template Criterion',
            weight: 3.0,
          ),
        ],
        scores: const {'tmpl-opt-1|tmpl-crit-1': 8.0},
      );

      cubit.startNew();
      cubit.applyTemplate(template);

      expect(cubit.state.decision!.id, isNull);
      expect(cubit.state.decision!.title, 'Template Decision');
      expect(cubit.state.decision!.options.length, 2);
      expect(cubit.state.decision!.criteria.length, 1);
      expect(cubit.state.decision!.scores, isEmpty);
      expect(cubit.state.decision!.result, isNull);

      // IDs should be different from template
      expect(
        cubit.state.decision!.options.first.id,
        isNot(equals('tmpl-opt-1')),
      );
    });

    test('applyTemplate should preserve method and weights', () {
      final template = Decision(
        title: 'Template',
        method: DecisionMethod.ahp,
        options: const [DecisionOption(id: 'o1', label: 'Option')],
        criteria: const [
          DecisionCriterion(id: 'c1', label: 'Criterion', weight: 5.0),
        ],
        scores: const {},
      );

      cubit.startNew();
      cubit.applyTemplate(template);

      expect(cubit.state.decision!.method, DecisionMethod.ahp);
      expect(cubit.state.decision!.criteria.first.weight, 5.0);
    });
  });

  group('DecisionEditorCubit - Evaluation', () {
    test('evaluate should call repository and save result', () async {
      mockRepository.mockResult = const DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 9.0, 'opt-2': 7.5},
        ranking: ['opt-1', 'opt-2'],
      );

      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Criterion 1');

      final option1Id = cubit.state.decision!.options[0].id;
      final option2Id = cubit.state.decision!.options[1].id;
      final criterionId = cubit.state.decision!.criteria.first.id;

      cubit.setScore(optionId: option1Id, criterionId: criterionId, score: 9.0);
      cubit.setScore(optionId: option2Id, criterionId: criterionId, score: 7.5);

      await cubit.evaluate();

      expect(cubit.state.isEvaluated, isTrue);
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.isSaving, isFalse);
      expect(cubit.state.isDirty, isFalse);
      expect(cubit.state.decision!.result, isNotNull);
      expect(cubit.state.decision!.id, isNotNull);
    });

    test('evaluate should set loading state during evaluation', () async {
      mockRepository.mockResult = const DecisionResult(
        bestOptionId: 'opt-1',
        scores: {'opt-1': 9.0},
        ranking: ['opt-1'],
      );

      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');

      final optionId = cubit.state.decision!.options.first.id;
      final criterionId = cubit.state.decision!.criteria.first.id;
      cubit.setScore(optionId: optionId, criterionId: criterionId, score: 9.0);

      final states = <DecisionEditorState>[];
      final subscription = cubit.stream.listen(states.add);

      await cubit.evaluate();
      await subscription.cancel();

      expect(states.any((s) => s.isLoading && s.isSaving), isTrue);
    });

    test('evaluate should handle errors gracefully', () async {
      mockRepository.shouldThrowOnEvaluate = true;
      mockRepository.errorMessage = 'Evaluation service unavailable';

      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');

      final optionId = cubit.state.decision!.options.first.id;
      final criterionId = cubit.state.decision!.criteria.first.id;
      cubit.setScore(optionId: optionId, criterionId: criterionId, score: 9.0);

      await cubit.evaluate();

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.isEvaluated, isFalse);
      expect(cubit.state.errorMessage, contains('Evaluation service'));
    });

    test('evaluate should reject incomplete decisions', () async {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');

      // Don't set score - decision is incomplete

      await cubit.evaluate();

      expect(cubit.state.errorMessage, isNotNull);
      expect(cubit.state.isEvaluated, isFalse);
    });

    test('evaluate should validate AHP completeness', () async {
      cubit.startNew();
      cubit.setMethod(DecisionMethod.ahp);
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Quality');
      cubit.addCriterion('Cost');

      // Fill in scores but not AHP comparisons
      for (var option in cubit.state.decision!.options) {
        for (var criterion in cubit.state.decision!.criteria) {
          cubit.setScore(
            optionId: option.id,
            criterionId: criterion.id,
            score: 5.0,
          );
        }
      }

      await cubit.evaluate();

      expect(cubit.state.errorMessage, isNotNull);
      expect(cubit.state.isEvaluated, isFalse);
    });
  });

  group('DecisionEditorCubit - Save', () {
    test('save should persist decision to repository', () async {
      cubit.startNew(title: 'My Decision');
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');

      await cubit.save();

      expect(cubit.state.isSaving, isFalse);
      expect(cubit.state.isDirty, isFalse);
      expect(cubit.state.decision!.id, isNotNull);
    });

    test('save should use fallback title when title is empty', () async {
      cubit.startNew();
      cubit.addOption('Option 1');

      await cubit.save(fallbackTitle: 'Untitled Decision');

      expect(cubit.state.decision!.title, 'Untitled Decision');
    });

    test('save should not override existing title with fallback', () async {
      cubit.startNew(title: 'Existing Title');
      cubit.addOption('Option 1');

      await cubit.save(fallbackTitle: 'Fallback Title');

      expect(cubit.state.decision!.title, 'Existing Title');
    });

    test('save should handle repository errors', () async {
      mockRepository.shouldThrowOnSave = true;
      mockRepository.errorMessage = 'Database connection failed';

      cubit.startNew(title: 'My Decision');
      cubit.addOption('Option 1');

      await cubit.save();

      expect(cubit.state.isSaving, isFalse);
      expect(cubit.state.errorMessage, contains('Database connection'));
    });

    test('save should set saving state during operation', () async {
      cubit.startNew(title: 'My Decision');
      cubit.addOption('Option 1');

      final states = <DecisionEditorState>[];
      final subscription = cubit.stream.listen(states.add);

      await cubit.save();
      await subscription.cancel();

      expect(states.any((s) => s.isSaving), isTrue);
    });
  });

  group('DecisionEditorCubit - Validation State', () {
    test('canEvaluate should require at least 2 options', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addCriterion('Criterion 1');

      expect(cubit.state.hasMinOptions, isFalse);
      expect(cubit.state.canEvaluate, isFalse);

      cubit.addOption('Option 2');
      expect(cubit.state.hasMinOptions, isTrue);
    });

    test('canEvaluate should require at least 1 criterion', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');

      expect(cubit.state.hasCriteria, isFalse);
      expect(cubit.state.canEvaluate, isFalse);

      cubit.addCriterion('Criterion 1');
      expect(cubit.state.hasCriteria, isTrue);
    });

    test('canEvaluate should require all scores filled', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Criterion 1');

      expect(cubit.state.canEvaluate, isFalse);

      final option1Id = cubit.state.decision!.options[0].id;
      final criterionId = cubit.state.decision!.criteria.first.id;
      cubit.setScore(optionId: option1Id, criterionId: criterionId, score: 7.0);

      expect(cubit.state.canEvaluate, isFalse);

      final option2Id = cubit.state.decision!.options[1].id;
      cubit.setScore(optionId: option2Id, criterionId: criterionId, score: 8.0);

      expect(cubit.state.canEvaluate, isTrue);
    });

    test('readyToSave should consider multiple conditions', () {
      cubit.startNew();

      // Not ready without proper setup
      expect(cubit.state.readyToSave, isFalse);

      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Criterion 1');

      // Still not ready without scores
      expect(cubit.state.readyToSave, isFalse);

      // Fill scores
      for (var option in cubit.state.decision!.options) {
        for (var criterion in cubit.state.decision!.criteria) {
          cubit.setScore(
            optionId: option.id,
            criterionId: criterion.id,
            score: 5.0,
          );
        }
      }

      // Now ready
      expect(cubit.state.readyToSave, isTrue);
    });
  });

  group('DecisionEditorCubit - Edge Cases', () {
    test('should handle rapid state changes', () {
      cubit.startNew();

      for (int i = 0; i < 10; i++) {
        cubit.addOption('Option $i');
      }

      expect(cubit.state.decision!.options.length, 10);
    });

    test('should handle empty string inputs gracefully', () {
      cubit.startNew();
      cubit.setTitle('');
      cubit.setDescription('');

      expect(cubit.state.decision!.title, isEmpty);
      expect(cubit.state.decision!.description, isEmpty);
    });

    test('should maintain state consistency across method switches', () {
      cubit.startNew();
      cubit.addOption('Option 1');
      cubit.addOption('Option 2');
      cubit.addCriterion('Quality');

      cubit.setMethod(DecisionMethod.ahp);
      cubit.setMethod(DecisionMethod.fuzzyWeightedSum);
      cubit.setMethod(DecisionMethod.weightedSum);

      expect(cubit.state.decision!.options.length, 2);
      expect(cubit.state.decision!.criteria.length, 1);
    });

    test('should handle removing last option', () {
      cubit.startNew();
      cubit.addOption('Only Option');

      final optionId = cubit.state.decision!.options.first.id;
      cubit.removeOption(optionId);

      expect(cubit.state.decision!.options, isEmpty);
      expect(cubit.state.hasMinOptions, isFalse);
    });

    test('should handle removing last criterion', () {
      cubit.startNew();
      cubit.addCriterion('Only Criterion');

      final criterionId = cubit.state.decision!.criteria.first.id;
      cubit.removeCriterion(criterionId);

      expect(cubit.state.decision!.criteria, isEmpty);
      expect(cubit.state.hasCriteria, isFalse);
    });
  });
}
