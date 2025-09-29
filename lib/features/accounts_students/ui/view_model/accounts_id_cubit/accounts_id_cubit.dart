import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/accounts_students/data/model/accounts_id_model.dart';
import 'package:icd_teacher/features/accounts_students/data/repo/accounts_id_repo.dart';

part 'accounts_id_state.dart';

class AccountsIdCubit extends Cubit<AccountsIdState> {
  AccountsIdCubit(this.repo) : super(AccountsIdInitial());
    final AccountsIdRepo repo;
  Future<void> getAccountsId(String id) async {
    emit(AccountsIdLoading());
    final result = await repo.getAccountsId(id);
    result.fold(
      (failure) => emit(AccountsIdError(failure.errMessage)),
      (response) => emit(AccountsIdSuccess(response)),
    );
  }

}
