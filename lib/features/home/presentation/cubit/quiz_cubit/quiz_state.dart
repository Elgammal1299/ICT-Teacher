// part of 'quiz_cubit.dart';

// sealed class QuizState extends Equatable {
//   const QuizState();

//   @override
//   List<Object> get props => [];
// }

// final class QuizInitial extends QuizState {}

// final class QuizLoading extends QuizState {}

// final class QuizSuccess extends QuizState {
//   final  QuizModel quiz;
//   const QuizSuccess(this.quiz);
// }
// final class QuizError extends QuizState {
//   final String errMessage;
//   const QuizError(this.errMessage);
// }
part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizError extends QuizState {
  final String message;
  QuizError(this.message);

  @override
  List<Object?> get props => [message];
}

class QuizSuccess extends QuizState {
  final QuizModel quiz;
  final Map<String, String> selectedAnswers; // questionId -> choiceId

  QuizSuccess({required this.quiz, required this.selectedAnswers});

  QuizSuccess copyWith({
    QuizModel? quiz,
    Map<String, String>? selectedAnswers,
  }) {
    return QuizSuccess(
      quiz: quiz ?? this.quiz,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }

  @override
  List<Object?> get props => [quiz, selectedAnswers];
}
