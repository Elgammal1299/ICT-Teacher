part of 'user_data_cubit.dart';

sealed class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

final class UserDataInitial extends UserDataState {}

final class UserDataLoading extends UserDataState {}

final class UserDataSuccess extends UserDataState {
  final UserModel response;
  const UserDataSuccess(this.response);
}

final class UserDataError extends UserDataState {
  const UserDataError(this.message);
  final String message;
}
