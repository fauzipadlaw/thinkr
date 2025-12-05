import 'package:injectable/injectable.dart';

import '../decision_repository.dart';
import '../entities/decision.dart';

@lazySingleton
class SaveDecisionUseCase {
  final DecisionRepository _repository;

  SaveDecisionUseCase(this._repository);

  Future<Decision> call(Decision decision) {
    return _repository.saveDecision(decision);
  }
}
