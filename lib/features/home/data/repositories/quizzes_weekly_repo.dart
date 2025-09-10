import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';

class QuizzesWeeklyRepo {
  final ApiService apiService;

  QuizzesWeeklyRepo(this.apiService);

  Future<Either<Failure, List<LessonsModel>>> getQuizzesWeeklyRepo(String termId ,contentType) async {
    try {
      final response = await apiService.getQuizzesWeekly(termId, contentType);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
