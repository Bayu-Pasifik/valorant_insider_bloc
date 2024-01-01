import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valorant_insider_bloc/UI/screen/Agent/detail_agent.dart';
import 'package:valorant_insider_bloc/cubit/agentCubit/agent_cubit.dart';
import 'package:valorant_insider_bloc/cubit/agentCubit/agent_state.dart';
import 'package:valorant_insider_bloc/data/models/agent_model.dart';
import 'package:valorant_insider_bloc/data/repository/repository.dart';
import 'package:valorant_insider_bloc/UI/constant/constant.dart';

class AgentView extends StatelessWidget {
  const AgentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Repository();
    final agentCubit = AgentCubit(repository);
    return BlocProvider(
      create: (context) => agentCubit..getAllAgents(),
      child: Scaffold(
        backgroundColor: blackgroundColor,
        appBar: AppBar(
          title: Text(
            "agent".toUpperCase(),
            style: GoogleFonts.bowlbyOneSc(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: blackgroundColor,
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
                    ? GridView.builder(
                        padding: EdgeInsets.all(8.r),
                        itemCount: value.agents.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1 / 1.6,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          AgentModel agent = value.agents[index];
                          return OpenContainer(
                            tappable: true,
                            transitionDuration:
                                const Duration(milliseconds: 800),
                            closedColor: Colors.transparent,
                            openColor: Colors.transparent,
                            clipBehavior: Clip.hardEdge,
                            closedBuilder: (context, action) {
                              return Container(
                                width: 200.w,
                                height: 200.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: redbackground, width: 1)),
                                child: Column(children: [
                                  Text(
                                    "${agent.displayName}",
                                    style: GoogleFonts.bowlbyOneSc(
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 220.w,
                                    height: 220.h,
                                    child: CachedNetworkImage(
                                      imageUrl: agent.fullPortrait!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/images/Image_not_available.png",
                                      ),
                                    ),
                                  ),
                                ]),
                              );
                            },
                            openBuilder: (context, action) {
                              return DetailAgent(
                                agent: agent,
                              );
                            },
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
