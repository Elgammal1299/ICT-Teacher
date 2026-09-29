import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';

class AnswersSubmitRepo {
  final ApiService apiService;

  AnswersSubmitRepo(this.apiService);

  Future<Either<Failure, AnswersQuestionsModel>> getSubmit(String id, AnswersRequestModel answersBody) async {
    try {
      final response = await apiService.getSubmit(id, answersBody);
      return Right(response);
    } on DioException catch (e) {
      // Handle HTTP 409 Conflict (Quiz already submitted)
      if (e.response?.statusCode == 409 && e.response?.data != null) {
        try {
          final data = e.response!.data;
          Map<String, dynamic>? submissionJson;
          if (data is Map<String, dynamic>) {
            if (data['submission'] is Map<String, dynamic>) {
              submissionJson = data['submission'] as Map<String, dynamic>;
            } else {
              submissionJson = data;
            }
          }
          if (submissionJson != null) {
            final existingResult = AnswersQuestionsModel.fromJson(submissionJson);
            return Right(existingResult);
          }
        } catch (_) {}
      }
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
