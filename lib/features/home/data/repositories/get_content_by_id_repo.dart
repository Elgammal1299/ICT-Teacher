import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/local/content_local_data_source.dart';
import 'package:icd_teacher/features/home/data/models/content_model.dart';

class GetcontentByIdRepo {
  final ApiService apiService;
  final ContentLocalDataSource localDataSource;

  GetcontentByIdRepo(this.apiService, this.localDataSource);

  Future<Either<Failure, ContentModel>> getcontentById(String id) async {
    try {
      final cachedContent = await localDataSource.getContentById(id);
      if (cachedContent != null) {
        return Right(cachedContent);
      }

      final response = await apiService.getContentById(id);
      try {
        await localDataSource.saveContent(response);
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
