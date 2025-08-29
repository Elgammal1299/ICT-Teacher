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
  const RegisterError(this.message);
  final String message;
}
