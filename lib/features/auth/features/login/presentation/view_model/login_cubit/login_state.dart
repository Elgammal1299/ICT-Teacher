part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponse response;
  const LoginSuccess(this.response);
}

final class LoginError extends LoginState {
  const LoginError(this.message);
  final String message;
}