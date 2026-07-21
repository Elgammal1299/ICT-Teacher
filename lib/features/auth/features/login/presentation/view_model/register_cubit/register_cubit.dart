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
      (failure) => emit(RegisterError(
        failure.errMessage,
        validationErrors: failure.validationErrors,
      )),
      (response) => emit(RegisterSuccess(response)),
    );
  }

  Future<void> checkUsername(String username) async {
    emit(CheckUsernameLoading());
    // Create a dummy body that is guaranteed to fail validation for OTHER fields
    final dummyRequest = RegisterBody(
      username: username,
      firstName: 'Test',
      middleName: 'Test',
      lastName: 'Test',
      email: '', // Empty email ensures it fails validation and won't create an account
      parentPhone: '',
      phone: '',
      password1: '',
      password2: '',
      grade: '',
      region: '',
    );
    
    final result = await repo.register(dummyRequest);
    result.fold(
      (failure) {
        if (failure.validationErrors != null) {
          final usernameErrors = failure.validationErrors!['username'];
          if (usernameErrors != null && usernameErrors.isNotEmpty) {
            // Username is taken or invalid
            emit(CheckUsernameError(usernameErrors.join(", ")));
            return;
          } else {
            // Username is NOT in the validation errors! This means it's available.
            emit(CheckUsernameSuccess());
            return;
          }
        }
        
        // If it's a different error (e.g. timeout) we might still want to proceed 
        // or show error. Let's show error so they can try again.
        emit(CheckUsernameError(failure.errMessage));
      },
      (response) {
        // This should theoretically never happen because email is empty, but just in case
        emit(CheckUsernameSuccess());
      },
    );
  }
}
