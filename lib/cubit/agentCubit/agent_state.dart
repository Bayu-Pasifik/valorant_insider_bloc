import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:valorant_insider_bloc/data/models/agent_model.dart';

part 'agent_state.freezed.dart';

@freezed
class AgentState with _$AgentState {
  const factory AgentState.initial() = _Initial;
  const factory AgentState.loading() = _Loading;
  const factory AgentState.loaded(List<AgentModel> agents) = _Loaded;
  const factory AgentState.error(String message) = _Error;
}
