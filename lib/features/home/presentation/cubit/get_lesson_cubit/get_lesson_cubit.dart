import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/data/repositories/lesson_repo.dart';

part 'get_lesson_state.dart';

class GetLessonCubit extends Cubit<GetLessonState> {
  GetLessonCubit(this.repo) : super(GetLessonInitial());
  final LessonRepo repo;
  Future<void> getLesson(String termId, contentType) async {
    emit(GetLessonLoading());
    final result = await repo.getLesson(termId, contentType);
    result.fold(
      (failure) => emit(GetLessonError(failure.errMessage)),
      (response) => emit(GetLessonSuccess(response)),
    );
  }
}
