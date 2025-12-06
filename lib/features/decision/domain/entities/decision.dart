import 'package:freezed_annotation/freezed_annotation.dart';

part 'decision.freezed.dart';

typedef DecisionId = String;
typedef OptionId = String;
typedef CriterionId = String;

/// Key format: "$optionId|$criterionId"
typedef ScoreKey = String;

enum DecisionMethod { weightedSum, ahp, fuzzyWeightedSum }

@freezed
abstract class DecisionOption with _$DecisionOption {
  const factory DecisionOption({
    required OptionId id,
    required String label,
    String? description,
  }) = _DecisionOption;
}

@freezed
abstract class DecisionCriterion with _$DecisionCriterion {
  const factory DecisionCriterion({
    required CriterionId id,
    required String label,
    @Default(1.0) double weight,
  }) = _DecisionCriterion;
}

@freezed
abstract class DecisionResult with _$DecisionResult {
  const factory DecisionResult({
    required OptionId bestOptionId,
    required Map<OptionId, double> scores,
    required List<OptionId> ranking,
    Map<String, dynamic>? debug,
  }) = _DecisionResult;
}

@freezed
abstract class Decision with _$Decision {
  const factory Decision({
    DecisionId? id,
    required String title,
    String? description,
    @Default(DecisionMethod.weightedSum) DecisionMethod method,
    @Default([]) List<DecisionOption> options,
    @Default([]) List<DecisionCriterion> criteria,
    @Default(<ScoreKey, double>{}) Map<ScoreKey, double> scores,
    DecisionResult? result,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) = _Decision;

  static const Decision empty = Decision(
    title: '',
    method: DecisionMethod.weightedSum,
  );
}
