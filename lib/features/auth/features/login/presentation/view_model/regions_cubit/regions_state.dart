part of 'regions_cubit.dart';

sealed class RegionsState extends Equatable {
  const RegionsState();

  @override
  List<Object> get props => [];
}

final class RegionsInitial extends RegionsState {}

final class RegionsLoading extends RegionsState {}

final class RegionsSuccess extends RegionsState {
  final RegionModel response;
  const RegionsSuccess(this.response);
}

final class RegionsError extends RegionsState {
  const RegionsError(this.message);
  final String message;
}
