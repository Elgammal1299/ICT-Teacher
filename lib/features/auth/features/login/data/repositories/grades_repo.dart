import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/grade_model.dart';

class GradesRepo {
  final ApiService apiService;

  GradesRepo(this.apiService);

  Future<Either<Failure, List<GradeModel>>> grades() async {
    try {
      final response = await apiService.grades();
      List<GradeModel> gradesList = [];
      if (response is List) {
        gradesList = response.map((e) => GradeModel.fromJson(e as Map<String, dynamic>)).toList();
      } else if (response is Map<String, dynamic> && response['results'] is List) {
        gradesList = (response['results'] as List)
            .map((e) => GradeModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return Right(gradesList);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
