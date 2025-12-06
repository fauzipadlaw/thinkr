import '../../decision/domain/entities/decision.dart';

class RankingEntry {
  final OptionId optionId;
  final String label;
  final double score;

  const RankingEntry({
    required this.optionId,
    required this.label,
    required this.score,
  });
}

class DecisionResultState {
  final Decision decision;
  final List<RankingEntry> ranking;
  final RankingEntry? best;

  const DecisionResultState({
    required this.decision,
    required this.ranking,
    required this.best,
  });

  bool get hasResult => decision.result != null;

  factory DecisionResultState.fromDecision(Decision decision) {
    final result = decision.result;
    if (result == null) {
      return DecisionResultState(
        decision: decision,
        ranking: const [],
        best: null,
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
    );
  }
}
