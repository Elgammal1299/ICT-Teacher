part of 'quizzes_monthly_cubit.dart';

sealed class QuizzesMonthyState extends Equatable {
  const QuizzesMonthyState();

  @override
  List<Object> get props => [];
}

final class QuizzesMonthyInitial extends QuizzesMonthyState {}
final class QuizzesMonthyLoading extends QuizzesMonthyState {}

final class QuizzesMonthySuccess extends QuizzesMonthyState {
  final List<LessonsModel> lessons;
  const QuizzesMonthySuccess(this.lessons);
}

final class QuizzesMonthyError extends QuizzesMonthyState {
  final String errMessage;
  const QuizzesMonthyError(this.errMessage);
}
