part of 'tram_grade_cubit.dart';

sealed class TramGradeState extends Equatable {
  const TramGradeState();

  @override
  List<Object> get props => [];
}

final class TramGradeInitial extends TramGradeState {}
final class TramGradeLoading extends TramGradeState {}
final class TramGradeSuccess extends TramGradeState {
  final TramGradeModel data;
  const TramGradeSuccess(this.data);

  @override
  List<Object> get props => [data];
}
final class TramGradeError extends TramGradeState {
  final String errMessage;
  const TramGradeError(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
