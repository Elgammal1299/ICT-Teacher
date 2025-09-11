part of 'quiz_cubit.dart';

sealed class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

final class QuizInitial extends QuizState {}

final class QuizLoading extends QuizState {}

final class QuizSuccess extends QuizState {
  final  QuizModel contentModel;
  const QuizSuccess(this.contentModel);
}
final class QuizError extends QuizState {
  final String errMessage;
  const QuizError(this.errMessage);
}