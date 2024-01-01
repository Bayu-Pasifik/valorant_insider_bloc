import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:valorant_insider_bloc/data/models/map_model.dart';
import 'package:valorant_insider_bloc/data/repository/repository.dart';

part 'map_state.dart';
part 'map_cubit.freezed.dart';

class MapCubit extends Cubit<MapState> {
  final CarouselController imageController = CarouselController();
  final Repository repository;
  MapCubit(this.repository) : super(const MapState.initial());
  Future<void> getAllmap() async {
    emit(const MapState.loading());
    try {
      final map = await repository.getAllMaps();
      emit(MapState.loaded(map));
    } catch (e) {
      emit(MapState.error(e.toString()));
    }
  }
}
