import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
import 'package:icd_teacher/features/home/data/repositories/quiz_by_id_repo.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this.repo) : super(QuizInitial());

  final QuizByIdRepo repo;

  Future<void> getQuizById(String termId) async {
    emit(QuizLoading());
    final result = await repo.getQuizById(termId);
    result.fold(
      (failure) => emit(QuizError(failure.errMessage)),
      (quiz) => emit(
        QuizSuccess(
          quiz: quiz,
          selectedAnswers: {},
        ),
      ),
    );
  }

  void selectAnswer({
    required String questionId,
    required String choiceId,
  }) {
    if (state is QuizSuccess) {
      final current = state as QuizSuccess;
      final updatedAnswers = Map<String, String>.from(current.selectedAnswers);
      updatedAnswers[questionId] = choiceId;

      emit(current.copyWith(selectedAnswers: updatedAnswers));
    }
  }

  void submitQuiz() {
    if (state is QuizSuccess) {
      final current = state as QuizSuccess;
      // هنا ممكن تبعت الإجابات للسيرفر أو تحسب الدرجة
      print("إجابات الطالب: ${current.selectedAnswers}");
    }
  }
}
