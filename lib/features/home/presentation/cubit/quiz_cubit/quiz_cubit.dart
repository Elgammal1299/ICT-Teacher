import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
import 'package:icd_teacher/features/home/data/repositories/quiz_by_id_repo.dart';
import 'package:icd_teacher/features/quizzes_monthly/data/repo/answers_submit_repo.dart';

part 'quiz_state.dart';

/// Central Cubit managing the Quiz lifecycle and student interaction.
/// Conforms to the requirements:
/// - State-driven Cubit (replaces StatefulWidget logic)
/// - GET /api/quizzes/{id}/ retrieves full questions and previous attempt status
/// - Immediately redirects if submission != null (backend source of truth)
/// - Supports MCQ single-choice, MCQ multiple-choice, and Essay inputs
/// - Supports question navigation (next/previous) with answer preservation
/// - Submits answers to POST /api/quizzes/{quiz_id}/submissions/
/// - Resolves HTTP 409 conflict transparently as existing submission result
class QuizCubit extends Cubit<QuizState> {
  final QuizByIdRepo quizRepo;
  final AnswersSubmitRepo submitRepo;

  QuizCubit(this.quizRepo, this.submitRepo) : super(const QuizInitial());

  /// Loads full quiz details from GET /api/quizzes/{id}/.
  /// If the backend indicates an existing submission, emits [QuizSubmitted] immediately.
  Future<void> getQuizById(String quizId) async {
    emit(const QuizLoading());
    final result = await quizRepo.getQuizById(quizId);
    result.fold(
      (failure) => emit(QuizError(failure.errMessage)),
      (quiz) {
        // Backend attempt check: if student already submitted, show result directly
        if (quiz.submission != null && quiz.submission!.id != null) {
          emit(QuizSubmitted(result: quiz.submission!, wasAlreadySubmitted: true));
        } else {
          emit(QuizInProgress(quiz: quiz));
        }
      },
    );
  }

  /// Selects or toggles an MCQ choice for the given question.
  /// - For `multiple == false`: replaces existing selection with this choice.
  /// - For `multiple == true`: toggles the choice inside the question's selection set.
  void selectMcqChoice({
    required String questionId,
    required String choiceId,
    required bool isMultiple,
  }) {
    if (state is! QuizInProgress) return;
    final current = state as QuizInProgress;
    final updatedMcq = Map<String, Set<String>>.from(
      current.mcqAnswers.map((k, v) => MapEntry(k, Set<String>.from(v))),
    );

    if (isMultiple) {
      final currentSet = updatedMcq[questionId] ?? <String>{};
      if (currentSet.contains(choiceId)) {
        currentSet.remove(choiceId);
      } else {
        currentSet.add(choiceId);
      }
      updatedMcq[questionId] = currentSet;
    } else {
      updatedMcq[questionId] = {choiceId};
    }

    emit(current.copyWith(mcqAnswers: updatedMcq, clearSubmissionError: true));
  }

  /// Updates student answer text for an essay question.
  void updateEssayAnswer({
    required String questionId,
    required String text,
  }) {
    if (state is! QuizInProgress) return;
    final current = state as QuizInProgress;
    final updatedEssays = Map<String, String>.from(current.essayAnswers);
    updatedEssays[questionId] = text.trim();
    emit(current.copyWith(essayAnswers: updatedEssays, clearSubmissionError: true));
  }

  /// Navigates to the next question, synchronizing active essay text if provided.
  void nextQuestion({String? currentEssayText}) {
    if (state is! QuizInProgress) return;
    final current = state as QuizInProgress;

    final updatedEssays = _syncEssayText(current, currentEssayText);

    if (current.currentQuestionIndex + 1 < current.totalQuestions) {
      emit(current.copyWith(
        currentQuestionIndex: current.currentQuestionIndex + 1,
        essayAnswers: updatedEssays,
        clearSubmissionError: true,
      ));
    }
  }

  /// Navigates to the previous question, synchronizing active essay text if provided.
  void previousQuestion({String? currentEssayText}) {
    if (state is! QuizInProgress) return;
    final current = state as QuizInProgress;

    final updatedEssays = _syncEssayText(current, currentEssayText);

    if (current.currentQuestionIndex > 0) {
      emit(current.copyWith(
        currentQuestionIndex: current.currentQuestionIndex - 1,
        essayAnswers: updatedEssays,
        clearSubmissionError: true,
      ));
    }
  }

  /// Submits the student's answers to the backend.
  /// Prepares the payload matching Swagger SubmissionCreateRequest:
  /// - MCQ questions send: `{"question": "uuid", "choices": ["uuid", ...]}`
  /// - Essay questions send: `{"question": "uuid", "text": "student answer"}`
  Future<void> submitQuiz({String? currentEssayText}) async {
    if (state is! QuizInProgress) return;
    final current = state as QuizInProgress;
    if (current.isSubmitting) return; // Prevent accidental double submission

    final updatedEssays = _syncEssayText(current, currentEssayText);
    emit(current.copyWith(
      isSubmitting: true,
      clearSubmissionError: true,
      essayAnswers: updatedEssays,
    ));

    final questions = current.quiz.questions ?? [];
    final List<AnswerItem> answerItems = [];

    for (final q in questions) {
      final qId = q.id ?? '';
      final isEssay = (q.questionType ?? '').toLowerCase() == 'essay';

      if (isEssay) {
        final text = updatedEssays[qId];
        if (text != null && text.isNotEmpty) {
          answerItems.add(AnswerItem(question: qId, text: text));
        }
      } else {
        final choices = current.mcqAnswers[qId];
        if (choices != null && choices.isNotEmpty) {
          answerItems.add(AnswerItem(question: qId, choices: choices.toList()));
        }
      }
    }

    final requestBody = AnswersRequestModel(answers: answerItems);
    final quizId = current.quiz.id ?? '';

    final result = await submitRepo.getSubmit(quizId, requestBody);
    result.fold(
      (failure) => emit(current.copyWith(
        isSubmitting: false,
        submissionError: failure.errMessage,
      )),
      (response) => emit(QuizSubmitted(result: response)),
    );
  }

  /// Helper to synchronize the current essay text into the essays map
  Map<String, String> _syncEssayText(QuizInProgress current, String? text) {
    if (text == null) return current.essayAnswers;
    final currentQ = current.currentQuestion;
    if (currentQ?.questionType?.toLowerCase() == 'essay') {
      final qId = currentQ?.id ?? '';
      if (qId.isNotEmpty) {
        final map = Map<String, String>.from(current.essayAnswers);
        map[qId] = text.trim();
        return map;
      }
    }
    return current.essayAnswers;
  }
}
