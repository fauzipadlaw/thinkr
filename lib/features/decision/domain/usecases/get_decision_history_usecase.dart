import 'package:injectable/injectable.dart';

import '../decision_repository.dart';
import '../entities/decision.dart';

@lazySingleton
class GetDecisionHistoryUseCase {
  final DecisionRepository _repository;

  GetDecisionHistoryUseCase(this._repository);

  Future<List<Decision>> call({int limit = 20, int offset = 0, String? query}) {
    return _repository.getHistory(limit: limit, offset: offset, query: query);
  }
}
