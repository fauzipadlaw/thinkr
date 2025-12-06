import 'package:injectable/injectable.dart';

import '../decision_repository.dart';
import '../entities/decision.dart';

@lazySingleton
class EvaluateDecisionUseCase {
  final DecisionRepository _repository;

  EvaluateDecisionUseCase(this._repository);

  Future<DecisionResult> call(Decision decision) {
    if (decision.options.isEmpty) {
      throw StateError('Decision requires at least one option.');
    }

    if (decision.criteria.isEmpty) {
      throw StateError('Decision requires at least one criterion.');
    }

    return _repository.evaluate(decision);
  }
}
