import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/lessons/data/local/lessons_local_data_source.dart';

class LessonRepo {
  final ApiService apiService;
  final LessonsLocalDataSource localDataSource;

  LessonRepo(this.apiService, this.localDataSource);

  Future<Either<Failure, List<LessonsModel>>> getLesson(
    String termId,
    contentType,
  ) async {
    try {
      final cachedLessons = await localDataSource.getLessons(
        termId,
        contentType,
      );
      if (cachedLessons != null) {
        return Right(cachedLessons);
      }

      final response = await apiService.getLessons(termId, contentType);
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
