import 'package:freezed_annotation/freezed_annotation.dart';
import '../../decision/domain/entities/decision.dart';

part 'decision_result_state.freezed.dart';

@freezed
abstract class RankingEntry with _$RankingEntry {
  const factory RankingEntry({
    required OptionId optionId,
    required String label,
    required double score,
  }) = _RankingEntry;
}

@freezed
abstract class DecisionResultState with _$DecisionResultState {
  const factory DecisionResultState({
    required Decision decision,
    required List<RankingEntry> ranking,
    RankingEntry? best,
    @Default(0) double errorRate,
    double? ahpConsistency,
    double? stability,
    double? fuzzyOverlapReliability,
    double? marginReliability,
    double? combinedReliability,
  }) = _DecisionResultState;

  const DecisionResultState._();

  bool get hasResult => decision.result != null;

  factory DecisionResultState.fromDecision(Decision decision) {
    final result = decision.result;
    if (result == null) {
      return DecisionResultState(
        decision: decision,
        ranking: const [],
        best: null,
        errorRate: 0,
        ahpConsistency: null,
        stability: null,
        fuzzyOverlapReliability: null,
        marginReliability: null,
        combinedReliability: null,
      );
    }

    final optionsById = {for (final o in decision.options) o.id: o.label};
    final orderedIds = result.ranking.isNotEmpty
        ? result.ranking
        : (result.scores.entries.toList()
                ..sort((a, b) => b.value.compareTo(a.value)))
              .map((e) => e.key)
              .toList();

    final ranking = orderedIds
        .map(
          (id) => RankingEntry(
            optionId: id,
            label: optionsById[id] ?? id,
            score: result.scores[id] ?? 0,
          ),
        )
        .toList();

    return DecisionResultState(
      decision: decision,
      ranking: ranking,
      best: ranking.isNotEmpty ? ranking.first : null,
      errorRate: result.errorRate,
      ahpConsistency: _toDouble(result.debug?['ahpConsistencyRatio']),
      stability: _toDouble(result.debug?['stability']),
      fuzzyOverlapReliability: _toDouble(result.debug?['overlapReliability']),
      marginReliability: _toDouble(result.debug?['marginReliability']),
      combinedReliability: _toDouble(result.debug?['combinedReliability']),
    );
  }
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}
