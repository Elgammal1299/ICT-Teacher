part of 'accounts_cubit.dart';

sealed class AccountsState extends Equatable {
  const AccountsState();

  @override
  List<Object> get props => [];
}

final class AccountsInitial extends AccountsState {}

final class AccountsLoading extends AccountsState {}

final class AccountsSuccess extends AccountsState {
  final List<AccountsModel> data;
  const AccountsSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class AccountsError extends AccountsState {
  final String errMessage;
  const AccountsError(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
