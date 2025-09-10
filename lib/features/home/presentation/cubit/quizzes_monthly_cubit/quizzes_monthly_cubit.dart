import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/data/repositories/quizzes_monthly_repo.dart';

part 'quizzes_monthly_state.dart';

class QuizzesMonthyCubit extends Cubit<QuizzesMonthyState> {
  QuizzesMonthyCubit(this.repo) : super(QuizzesMonthyInitial());
  final QuizzesMonthlyRepo repo;
  Future<void> getQuizzesMonthly(String termId, contentType) async {
    emit(QuizzesMonthyLoading());
    final result = await repo.getQuizzesMonthlyRepo(termId, contentType);
    result.fold(
      (failure) => emit(QuizzesMonthyError(failure.errMessage)),
      (response) => emit(QuizzesMonthySuccess(response)),
    );
  }
}
