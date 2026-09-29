import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';

/// Repository responsible for submitting student quiz answers and handling responses.
/// Per Swagger contract:
/// - POST /api/quizzes/{quiz_id}/submissions/ returns 201 Created with SubmissionResult.
/// - Returns 409 Conflict with SubmissionConflict envelope ({detail, submission}) if already submitted.
class AnswersSubmitRepo {
  final ApiService apiService;

  AnswersSubmitRepo(this.apiService);

  /// Submits quiz answers to the backend.
  /// If the quiz was already submitted (HTTP 409), the existing submission is parsed
  /// and treated as a valid successful result so the student can view their official submission.
  Future<Either<Failure, AnswersQuestionsModel>> getSubmit(String id, AnswersRequestModel answersBody) async {
    try {
      final response = await apiService.getSubmit(id, answersBody);
      return Right(response);
    } on DioException catch (e) {
      // Handle HTTP 409 Conflict: Swagger SubmissionConflict envelope `{detail, submission}`
      if (e.response?.statusCode == 409 && e.response?.data != null) {
        try {
          dynamic rawData = e.response!.data;
          if (rawData is String && rawData.isNotEmpty) {
            try {
              rawData = jsonDecode(rawData);
            } catch (_) {}
          }

          Map<String, dynamic>? submissionJson;
          if (rawData is Map<String, dynamic>) {
            if (rawData['submission'] is Map<String, dynamic>) {
              submissionJson = rawData['submission'] as Map<String, dynamic>;
            } else {
              submissionJson = rawData;
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
