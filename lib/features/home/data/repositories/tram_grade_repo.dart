import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/tram_grade_model.dart';

class TramGradeRepo {
  final ApiService apiService;

  TramGradeRepo(this.apiService);

  Future<Either<Failure, TramGradeModel>> tramGrade(String id) async {
    try {
      final response = await apiService.gradeId(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
