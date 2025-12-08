import 'package:thinkr/features/decision/domain/decision_repository.dart';
import 'package:thinkr/features/decision/domain/entities/decision.dart';

class MockDecisionRepository implements DecisionRepository {
  final List<Decision> _decisions = [];
  bool shouldThrowOnSave = false;
  bool shouldThrowOnEvaluate = false;
  bool shouldThrowOnGet = false;
  bool shouldThrowOnDelete = false;
  String? errorMessage;
  DecisionResult? mockResult;

  @override
  Future<Decision> saveDecision(Decision decision) async {
    if (shouldThrowOnSave) {
      throw Exception(errorMessage ?? 'Save failed');
    }
    final saved = decision.copyWith(
      id: decision.id ?? 'saved-${DateTime.now().millisecondsSinceEpoch}',
      createdAt: decision.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _decisions.add(saved);
    return saved;
  }

  @override
  Future<List<Decision>> getHistory({
    int limit = 20,
    int offset = 0,
    String? query,
  }) async {
    if (shouldThrowOnGet) {
      throw Exception(errorMessage ?? 'Get history failed');
    }
    var results = List<Decision>.from(_decisions);
    if (query != null && query.isNotEmpty) {
      results = results
          .where((d) => d.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    return results.skip(offset).take(limit).toList();
  }

  @override
  Future<Decision?> getDecision(DecisionId id) async {
    if (shouldThrowOnGet) {
      throw Exception(errorMessage ?? 'Get decision failed');
    }
    try {
      return _decisions.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> softDeleteDecision(DecisionId id) async {
    if (shouldThrowOnDelete) {
      throw Exception(errorMessage ?? 'Delete failed');
    }
    final index = _decisions.indexWhere((d) => d.id == id);
    if (index != -1) {
      _decisions[index] = _decisions[index].copyWith(
        deletedAt: DateTime.now(),
      );
    }
  }

  @override
  Future<DecisionResult> evaluate(Decision decision) async {
    if (shouldThrowOnEvaluate) {
      throw Exception(errorMessage ?? 'Evaluation failed');
    }
    return mockResult ??
        const DecisionResult(
          bestOptionId: 'opt-1',
          scores: {'opt-1': 8.5, 'opt-2': 7.2},
          ranking: ['opt-1', 'opt-2'],
        );
  }

  void clear() {
    _decisions.clear();
  }
}