part of 'accounts_id_cubit.dart';

sealed class AccountsIdState extends Equatable {
  const AccountsIdState();

  @override
  List<Object> get props => [];
}

final class AccountsIdInitial extends AccountsIdState {}
final class AccountsIdLoading extends AccountsIdState {}
final class AccountsIdSuccess extends AccountsIdState {
  final AccountsIdModel data;
  const AccountsIdSuccess(this.data);

  @override
  List<Object> get props => [data];
}
final class AccountsIdError extends AccountsIdState {
  final String errMessage;
  const AccountsIdError(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}