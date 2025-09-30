import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/home/data/models/tram_grade_model.dart';
import 'package:icd_teacher/features/home/data/repositories/tram_grade_repo.dart';

part 'tram_grade_state.dart';

class TramGradeCubit extends Cubit<TramGradeState> {
  TramGradeCubit(this.repo) : super(TramGradeInitial());
  final TramGradeRepo repo;
  Future<void> tramGrade(String id) async {
    emit(TramGradeLoading());
    final result = await repo.tramGrade(id);
    result.fold(
      (failure) => emit(TramGradeError(failure.errMessage)),
      (response) => emit(TramGradeSuccess(response)),
    );
  }
}
