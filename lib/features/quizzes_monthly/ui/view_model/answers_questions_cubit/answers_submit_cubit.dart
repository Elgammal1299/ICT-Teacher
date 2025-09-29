import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';
import 'package:icd_teacher/features/quizzes_monthly/data/repo/answers_submit_repo.dart';

part 'answers_submit_state.dart';

class AnswersSubmitCubit extends Cubit<AnswersSubmitState> {
  AnswersSubmitCubit(this.repo) : super(AnswersSubmitInitial());
  final AnswersSubmitRepo repo;
  Future<void> getSubmit(String quizId,AnswersRequestModel answersBody) async {
    emit(AnswersSubmitLoading());
    final result = await repo.getSubmit(quizId,answersBody);
    result.fold(
      (failure) => emit(AnswersSubmitError(failure.errMessage)),
      (response) => emit(AnswersSubmitSuccess(response)),
    );
  }
}
