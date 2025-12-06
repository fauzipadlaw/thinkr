import 'package:flutter_bloc/flutter_bloc.dart';

import '../../decision/domain/entities/decision.dart';
import 'decision_result_state.dart';

class DecisionResultCubit extends Cubit<DecisionResultState> {
  DecisionResultCubit(Decision decision)
    : super(DecisionResultState.fromDecision(decision));

  void updateDecision(Decision decision) {
    emit(DecisionResultState.fromDecision(decision));
  }
}
