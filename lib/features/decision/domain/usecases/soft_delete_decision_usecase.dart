import 'package:injectable/injectable.dart';

import '../decision_repository.dart';
import '../entities/decision.dart';

@lazySingleton
class SoftDeleteDecisionUseCase {
  final DecisionRepository _repository;

  SoftDeleteDecisionUseCase(this._repository);

  Future<void> call(DecisionId id) {
    return _repository.softDeleteDecision(id);
  }
}
