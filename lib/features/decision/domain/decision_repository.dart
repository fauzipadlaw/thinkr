import 'entities/decision.dart';

abstract class DecisionRepository {
  Future<Decision> saveDecision(Decision decision);
  Future<List<Decision>> getHistory();
  Future<Decision?> getDecision(DecisionId id);
  Future<void> softDeleteDecision(DecisionId id);
}
