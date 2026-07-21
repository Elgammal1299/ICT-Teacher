part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final RegisterResponse response;
  const RegisterSuccess(this.response);
}

final class RegisterError extends RegisterState {
  const RegisterError(this.message, {this.validationErrors});
  final String message;
  final Map<String, List<String>>? validationErrors;
}

final class CheckUsernameLoading extends RegisterState {}

final class CheckUsernameSuccess extends RegisterState {}

final class CheckUsernameError extends RegisterState {
  final String message;
  const CheckUsernameError(this.message);
}
