import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorant_insider_bloc/data/repository/repository.dart';

import 'agent_state.dart';

class AgentCubit extends Cubit<AgentState> {
  final Repository repository;

  AgentCubit(this.repository) : super(const AgentState.initial());

  Future<void> getAllAgents() async {
    emit(const AgentState.loading());
    try {
      final agents = await repository.getAllAgent();
      emit(AgentState.loaded(agents));
    } catch (e) {
      emit(AgentState.error(e.toString()));
    }
  }
}
