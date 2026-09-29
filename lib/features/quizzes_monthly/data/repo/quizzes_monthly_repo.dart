import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';

class QuizzesMonthlyRepo {
  final ApiService apiService;

  QuizzesMonthlyRepo(this.apiService);

  Future<Either<Failure, List<LessonsModel>>> getQuizzesMonthlyRepo(String termId, contentType) async {
    try {
      final response = await apiService.getExams(termId);
      List<LessonsModel> list = [];
      if (response is List) {
        list = response.map((e) => LessonsModel.fromJson(e as Map<String, dynamic>)).toList();
      } else if (response is Map<String, dynamic> && response['results'] is List) {
        list = (response['results'] as List)
            .map((e) => LessonsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return Right(list);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
