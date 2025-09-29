import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/accounts_students/data/model/accounts_model.dart';
import 'package:icd_teacher/features/accounts_students/data/repo/accounts_repo.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  AccountsCubit(this.repo) : super(AccountsInitial());
    final AccountsRepo repo;
  Future<void> getAccounts() async {
    emit(AccountsLoading());
    final result = await repo.getAccounts();
    result.fold(
      (failure) => emit(AccountsError(failure.errMessage)),
      (response) => emit(AccountsSuccess(response)),
    );
  }
}

