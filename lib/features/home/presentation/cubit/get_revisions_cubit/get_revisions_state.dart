part of 'get_revisions_cubit.dart';

sealed class GetRevisionsState extends Equatable {
  const GetRevisionsState();

  @override
  List<Object> get props => [];
}

final class GetRevisionsInitial extends GetRevisionsState {}
final class GetRevisionsLoading extends GetRevisionsState {}

final class GetRevisionsSuccess extends GetRevisionsState {
  final List<LessonsModel> lessons;
  const GetRevisionsSuccess(this.lessons);
}
final class GetRevisionsError extends GetRevisionsState {
  final String errMessage;
  const GetRevisionsError(this.errMessage);
}
