import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';

class AnswersSubmitRepo {
  final ApiService apiService;

  AnswersSubmitRepo(this.apiService);

  Future<Either<Failure, AnswersQuestionsModel>> getSubmit(String id,AnswersRequestModel answersBody) async {
    try {
      final response = await apiService.getSubmit(id,answersBody);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
