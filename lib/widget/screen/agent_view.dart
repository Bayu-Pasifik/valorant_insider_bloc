import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorant_insider_bloc/cubit/agentCubit/agent_cubit.dart';
import 'package:valorant_insider_bloc/cubit/agentCubit/agent_state.dart';
import 'package:valorant_insider_bloc/data/models/agent_model.dart';
import 'package:valorant_insider_bloc/data/repository/repository.dart';

class AgentView extends StatelessWidget {
  const AgentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Repository();
    final agentCubit = AgentCubit(repository);
    // agentCubit.getAllAgents();

    return BlocProvider(
      create: (context) => agentCubit..getAllAgents(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Agent',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: BlocBuilder<AgentCubit, AgentState>(
          builder: (context, state) {
            return state.maybeMap(
              initial: (value) => const Center(
                child: CircularProgressIndicator(),
              ),
              loading: (value) => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (value) {
                return (value.agents.isNotEmpty)
                    ? ListView.builder(
                        itemCount: value.agents.length,
                        itemBuilder: (context, index) {
                          AgentModel agent = value.agents[index];
                          return ListTile(
                            title: Text(agent.displayName!),
                          );
                        },
                      )
                    : const Center(
                        child: Text("Data Kosong"),
                      );
              },
              error: (value) => Center(
                child: Text(value.message),
              ),
              orElse: () => const Center(
                child: Text("Error occurred"),
              ),
            );
          },
        ),
      ),
    );
  }
}
