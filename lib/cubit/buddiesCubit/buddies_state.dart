part of 'buddies_cubit.dart';

@freezed
class BuddiesState with _$BuddiesState {
  const factory BuddiesState.initial() = _Initial;
  const factory BuddiesState.loading() = _Loading;
  const factory BuddiesState.loaded(List<BuddiesModel> buddies) = _Loaded;
  const factory BuddiesState.error(String message) = _Error;
}
