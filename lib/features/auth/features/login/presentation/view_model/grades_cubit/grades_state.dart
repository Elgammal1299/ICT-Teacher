part of 'grades_cubit.dart';

sealed class GradesState extends Equatable {
  const GradesState();

  @override
  List<Object> get props => [];
}

final class GradesInitial extends GradesState {}

final class GradesLoading extends GradesState {}

final class GradesSuccess extends GradesState {
  final GradeModel response;
  const GradesSuccess(this.response);
}

final class GradesError extends GradesState {
  const GradesError(this.message);
  final String message;
}
