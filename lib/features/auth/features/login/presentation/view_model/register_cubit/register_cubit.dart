import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/register_body.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/register_response.dart';
import 'package:icd_teacher/features/auth/features/login/data/repositories/register_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.repo) : super(RegisterInitial());
  final RegisterRepo repo;
  Future<void> register(RegisterBody request) async {
    emit(RegisterLoading());
    final result = await repo.register(request);
    result.fold(
      (failure) => emit(RegisterError(failure.errMessage)),
      (response) => emit(RegisterSuccess(response)),
    );
  }
}
