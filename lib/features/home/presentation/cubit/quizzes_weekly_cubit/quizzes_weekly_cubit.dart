import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/data/repositories/quizzes_weekly_repo.dart';

part 'quizzes_weekly_state.dart';

class QuizzesWeeklyCubit extends Cubit<QuizzesWeeklyState> {
  QuizzesWeeklyCubit(this.repo) : super(QuizzesWeeklyInitial());
  final QuizzesWeeklyRepo repo;
  Future<void> getQuizzesWeekly(String termId, contentType) async {
    emit(QuizzesWeeklyLoading());
    final result = await repo.getQuizzesWeeklyRepo(termId, contentType);
    result.fold(
      (failure) => emit(QuizzesWeeklyError(failure.errMessage)),
      (response) => emit(QuizzesWeeklySuccess(response)),
    );
  }
}
