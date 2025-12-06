import 'entities/decision.dart';

abstract class DecisionRepository {
  Future<Decision> saveDecision(Decision decision);
  Future<List<Decision>> getHistory({
    int limit = 20,
    int offset = 0,
    String? query,
  });
  Future<Decision?> getDecision(DecisionId id);
  Future<void> softDeleteDecision(DecisionId id);
  Future<DecisionResult> evaluate(Decision decision);
}
