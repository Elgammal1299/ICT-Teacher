import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/constant/shared_preferences_key.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/login_body.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/login_response.dart';

class LoginRepo {
  final ApiService apiService;

  LoginRepo(this.apiService);

  Future<Either<Failure, LoginResponse>> login(LoginBody body) async {
    try {
      final response = await apiService.login(body);
      if (response.access.isNotEmpty) {
        await SharedPrefHelper.setSecuredString(
          SharedPreferencesKeys.accessToken,
          response.access,
        );
        log("Token saved successfully!");
      }
      if (response.refresh.isNotEmpty) {
        await SharedPrefHelper.setSecuredString(
          SharedPreferencesKeys.refreshToken,
          response.refresh,
        );
        log("Refresh Token saved successfully!");
      }

      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
