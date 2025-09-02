import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/user_model.dart';

class UserRepo {
  final ApiService apiService;

  UserRepo(this.apiService);

  Future<Either<Failure, UserModel>> userData() async {
    try {
      final response = await apiService.user();
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
