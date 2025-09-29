part of 'quizzes_weekly_cubit.dart';

sealed class QuizzesWeeklyState extends Equatable {
  const QuizzesWeeklyState();

  @override
  List<Object> get props => [];
}

final class QuizzesWeeklyInitial extends QuizzesWeeklyState {}

final class QuizzesWeeklyLoading extends QuizzesWeeklyState {}

final class QuizzesWeeklySuccess extends QuizzesWeeklyState {
  final List<LessonsModel> lessons;
  const QuizzesWeeklySuccess(this.lessons);
}

final class QuizzesWeeklyError extends QuizzesWeeklyState {
  final String errMessage;
  const QuizzesWeeklyError(this.errMessage);
}
