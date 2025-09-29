part of 'get_lesson_cubit.dart';

sealed class GetLessonState extends Equatable {
  const GetLessonState();

  @override
  List<Object> get props => [];
}

final class GetLessonInitial extends GetLessonState {}

final class GetLessonLoading extends GetLessonState {}

final class GetLessonSuccess extends GetLessonState {
  final List<LessonsModel> lessons;
  const GetLessonSuccess(this.lessons);
}
final class GetLessonError extends GetLessonState {
  final String errMessage;
  const GetLessonError(this.errMessage);
}

