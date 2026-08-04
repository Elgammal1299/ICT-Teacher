import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/lessons/data/local/lessons_local_data_source.dart';

class RevisionsRepo {
  final ApiService apiService;
  final LessonsLocalDataSource localDataSource;

  RevisionsRepo(this.apiService, this.localDataSource);

  Future<Either<Failure, List<LessonsModel>>> getRevisions(
    String termId,
    contentType,
  ) async {
    try {
      final cachedRevisions = await localDataSource.getLessons(
        termId,
        contentType,
      );
      if (cachedRevisions != null) {
        return Right(cachedRevisions);
      }

      final response = await apiService.getRevisions(termId, contentType);
      try {
        await localDataSource.saveLessons(termId, contentType, response);
      } catch (_) {
        // Cache write failures should not block displaying remote content.
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
