import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/home/data/models/user_model.dart';
import 'package:icd_teacher/features/home/data/repositories/user_repo.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this.repo) : super(UserDataInitial());
  final UserRepo repo;
  Future<void> userData() async {
    emit(UserDataLoading());
    final result = await repo.userData();
    result.fold(
      (failure) => emit(UserDataError(failure.errMessage)),
      (response) => emit(UserDataSuccess(response)),
    );
  }
}
