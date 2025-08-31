import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/login_body.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/login_response.dart';
import 'package:icd_teacher/features/auth/features/login/data/repositories/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.repo) : super(LoginInitial());
  final LoginRepo repo;
  Future<void> login(LoginBody request) async {
    emit(LoginLoading());
    final result = await repo.login(request);
    result.fold(
      (failure) => emit(LoginError(failure.errMessage)),
      (response) => emit(LoginSuccess(response)),
    );
  }
}
