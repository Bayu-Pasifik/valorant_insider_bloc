import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:valorant_insider_bloc/data/models/buddies_model.dart';
import 'package:valorant_insider_bloc/data/repository/repository.dart';

part 'buddies_state.dart';
part 'buddies_cubit.freezed.dart';

class BuddiesCubit extends Cubit<BuddiesState> {
  final Repository repository;
  BuddiesCubit(this.repository) : super(const BuddiesState.initial());
  Future<void> getAllBuddies() async {
    emit(const BuddiesState.loading());
    try {
      final buddies = await repository.getAllBuddies();
      emit(BuddiesState.loaded(buddies));
    } catch (e) {
      emit(BuddiesState.error(e.toString()));
    }
  }
}
