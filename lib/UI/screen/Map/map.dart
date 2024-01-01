import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valorant_insider_bloc/UI/constant/constant.dart';
import 'package:valorant_insider_bloc/UI/screen/Map/detail_map.dart';
import 'package:valorant_insider_bloc/cubit/mapCubit/map_cubit.dart';
import 'package:valorant_insider_bloc/data/models/map_model.dart';
import 'package:valorant_insider_bloc/data/repository/repository.dart';

class MapsView extends StatelessWidget {
  const MapsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final repository = Repository();
    return BlocProvider(
      create: (context) => MapCubit(repository)..getAllmap(),
      child: Scaffold(
          backgroundColor: blackgroundColor,
          appBar: AppBar(
            title: Text(
              "maps".toUpperCase(),
              style: GoogleFonts.bowlbyOneSc(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: blackgroundColor,
          ),
          body: BlocBuilder<MapCubit, MapState>(
            builder: (context, state) {
              return state.maybeMap(
                initial: (value) => const Center(
                  child: CircularProgressIndicator(),
                ),
                loading: (value) => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (item) => GridView.builder(
                  padding: EdgeInsets.all(8.r),
                  itemCount: item.mapmodel.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1 / 1.6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    MapModel map = item.mapmodel[index];
                    // print(map.displayIcon);
                    return OpenContainer(
                      tappable: true,
                      transitionDuration: const Duration(milliseconds: 800),
                      closedColor: Colors.transparent,
                      openColor: Colors.transparent,
                      clipBehavior: Clip.hardEdge,
                      openBuilder: (context, action) => DetailMap(),
                      closedBuilder: (context, action) => Container(
                        width: 200.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: redbackground, width: 1)),
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Column(children: [
                            SizedBox(
                              width: 200.w,
                              height: 20.h,
                              child: Text(
                                "${map.displayName}",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.bowlbyOneSc(
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 200.w,
                              height: 200.h,
                              child: CachedNetworkImage(
                                imageUrl: map.displayIcon ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
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
                      ),
                    );
                  },
                ),
                orElse: () => Center(
                  child: Text(
                    "Something went wrong",
                    style: GoogleFonts.bowlbyOneSc(color: Colors.white),
                  ),
                ),
              );
            },
          )),
    );
  }
}
