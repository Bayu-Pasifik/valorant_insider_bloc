import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valorant_insider_bloc/UI/constant/constant.dart';
import 'package:valorant_insider_bloc/cubit/buddiesCubit/buddies_cubit.dart';
import 'package:valorant_insider_bloc/data/models/buddies_model.dart';
import 'package:valorant_insider_bloc/data/repository/repository.dart';

class BuddiesView extends StatelessWidget {
  const BuddiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final repository = Repository();
    return BlocProvider(
      create: (context) => BuddiesCubit(repository)..getAllBuddies(),
      child: Scaffold(
          backgroundColor: blackgroundColor,
          appBar: AppBar(
            title: Text(
              "buddies".toUpperCase(),
              style: GoogleFonts.bowlbyOneSc(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: blackgroundColor,
          ),
          body: BlocBuilder<BuddiesCubit, BuddiesState>(
            builder: (context, state) {
              return state.maybeMap(
                initial: (value) => const Center(
                  child: CircularProgressIndicator(),
                ),
                loading: (value) => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (item) {
                  return (item.buddies.isNotEmpty)
                      ? GridView.builder(
                          padding: EdgeInsets.all(8.r),
                          itemCount: item.buddies.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 1 / 1.6,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            BuddiesModel buddie = item.buddies[index];
                            // print(buddie.displayIcon);
                            return Container(
                              width: 200.w,
                              height: 200.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: redbackground, width: 1)),
                              child: Padding(
                                padding: EdgeInsets.all(8.r),
                                child: Column(children: [
                                  SizedBox(
                                    width: 200.w,
                                    height: 20.h,
                                    child: Text(
                                      "${buddie.displayName}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.bowlbyOneSc(
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200.w,
                                    height: 200.h,
                                    child: CachedNetworkImage(
                                      imageUrl: buddie.displayIcon!,
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
                              ),
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
          )),
    );
  }
}
