import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/region_model.dart';
import 'package:icd_teacher/features/auth/features/login/data/repositories/region_repo.dart';

part 'regions_state.dart';

class RegionsCubit extends Cubit<RegionsState> {
  RegionsCubit(this.repo) : super(RegionsInitial());
  final RegionRepo repo;
  Future<void> regions() async {
    emit(RegionsLoading());
    final result = await repo.regions();
    result.fold(
      (failure) => emit(RegionsError(failure.errMessage)),
      (response) => emit(RegionsSuccess(response)),
    );
  }
}
