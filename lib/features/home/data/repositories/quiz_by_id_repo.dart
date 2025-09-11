import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';

class QuizByIdRepo {
  final ApiService apiService;

  QuizByIdRepo(this.apiService);

  Future<Either<Failure,QuizModel >> getQuizById(String id ) async {
    try {
      final response = await apiService.getQuizById(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
