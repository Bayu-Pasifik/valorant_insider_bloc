part of 'map_cubit.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.initial() = _Initial;
  const factory MapState.loading() = _Loading;
  const factory MapState.loaded(List<MapModel> mapmodel) = _Loaded;
  const factory MapState.error(String message) = _Error;
}
