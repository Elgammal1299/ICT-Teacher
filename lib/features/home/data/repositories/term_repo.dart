import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/local/user_local_data_source.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';

class TermRepo {
  final ApiService apiService;
  final UserLocalDataSource? localDataSource;

  TermRepo(this.apiService, [this.localDataSource]);

  Future<Either<Failure, List<TermModel>>> getTermRepo([String? gradeId]) async {
    try {
      String? targetGradeId = gradeId;
      if (targetGradeId == null || targetGradeId.trim().isEmpty) {
        if (localDataSource != null) {
          final cachedUser = await localDataSource!.getUser();
          if (cachedUser != null && cachedUser.gradeId.isNotEmpty) {
            targetGradeId = cachedUser.gradeId;
          }
        }
      }
      if (targetGradeId == null || targetGradeId.trim().isEmpty) {
        final user = await apiService.user();
        targetGradeId = user.gradeId;
      }
      final response = await apiService.termsByGrade(targetGradeId);
      List<TermModel> terms = [];
      if (response is List) {
        terms = response.map((e) => TermModel.fromJson(e as Map<String, dynamic>)).toList();
      } else if (response is Map<String, dynamic> && response['results'] is List) {
        terms = (response['results'] as List)
            .map((e) => TermModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return Right(terms);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
