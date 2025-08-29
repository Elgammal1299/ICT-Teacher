import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/grade_model.dart';
import 'package:icd_teacher/features/auth/features/login/data/repositories/grades_repo.dart';

part 'grades_state.dart';

class GradesCubit extends Cubit<GradesState> {
  GradesCubit(this.repo) : super(GradesInitial());
  final GradesRepo repo;
  Future<void> grades() async {
    emit(GradesLoading());
    final result = await repo.grades();
    result.fold(
      (failure) => emit(GradesError(failure.errMessage)),
      (response) => emit(GradesSuccess(response)),
    );
  }
}
