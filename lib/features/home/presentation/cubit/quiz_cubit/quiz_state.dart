part of 'quiz_cubit.dart';

/// Base state for the Quiz state machine.
abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the Quiz screen is created.
class QuizInitial extends QuizState {
  const QuizInitial();
}

/// State emitted while fetching Quiz details from GET /api/quizzes/{id}/.
class QuizLoading extends QuizState {
  const QuizLoading();
}

/// State emitted when fetching the Quiz fails.
class QuizError extends QuizState {
  final String errMessage;

  const QuizError(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}

/// Active quiz-taking state managing questions, user selections, and submission status.
/// All interactive state is kept in this Cubit state to ensure the UI remains a pure StatelessWidget.
class QuizInProgress extends QuizState {
  final QuizModel quiz;
  final int currentQuestionIndex;

  /// Map of question UUID -> Set of selected choice UUIDs (supports single and multiple choice MCQ)
  final Map<String, Set<String>> mcqAnswers;

  /// Map of question UUID -> student essay text
  final Map<String, String> essayAnswers;

  /// Indicates whether the POST /api/quizzes/{quiz_id}/submissions/ request is in flight
  final bool isSubmitting;

  /// Submission failure message if the submit request failed with an unhandled server error
  final String? submissionError;

  const QuizInProgress({
    required this.quiz,
    this.currentQuestionIndex = 0,
    this.mcqAnswers = const {},
    this.essayAnswers = const {},
    this.isSubmitting = false,
    this.submissionError,
  });

  /// Currently active question
  QuestionModel? get currentQuestion {
    final questions = quiz.questions ?? [];
    if (questions.isEmpty || currentQuestionIndex >= questions.length || currentQuestionIndex < 0) {
      return null;
    }
    return questions[currentQuestionIndex];
  }

  int get totalQuestions => quiz.questions?.length ?? 0;
  bool get isFirstQuestion => currentQuestionIndex == 0;
  bool get isLastQuestion => currentQuestionIndex >= totalQuestions - 1;

  QuizInProgress copyWith({
    QuizModel? quiz,
    int? currentQuestionIndex,
    Map<String, Set<String>>? mcqAnswers,
    Map<String, String>? essayAnswers,
    bool? isSubmitting,
    String? submissionError,
    bool clearSubmissionError = false,
  }) {
    return QuizInProgress(
      quiz: quiz ?? this.quiz,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      mcqAnswers: mcqAnswers ?? this.mcqAnswers,
      essayAnswers: essayAnswers ?? this.essayAnswers,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submissionError: clearSubmissionError ? null : (submissionError ?? this.submissionError),
    );
  }

  @override
  List<Object?> get props => [
    quiz,
    currentQuestionIndex,
    mcqAnswers,
    essayAnswers,
    isSubmitting,
    submissionError,
  ];
}

/// Terminal state emitted when a submission is successfully processed (201 Created or 409 Conflict),
/// or when an existing attempt is detected upon loading the quiz from GET /api/quizzes/{id}/.
class QuizSubmitted extends QuizState {
  final AnswersQuestionsModel result;
  final bool wasAlreadySubmitted;

  const QuizSubmitted({
    required this.result,
    this.wasAlreadySubmitted = false,
  });

  @override
  List<Object?> get props => [result, wasAlreadySubmitted];
}
