import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
import 'package:icd_teacher/features/home/data/repositories/quiz_by_id_repo.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this.repo) : super(QuizInitial());
    final QuizByIdRepo repo;
  Future<void> getContentById(String termId) async {
    emit(QuizLoading());
    final result = await repo.getQuizById(termId);
    result.fold(
      (failure) => emit(QuizError(failure.errMessage)),
      (response) => emit(QuizSuccess(response)),
    );
  }
}
