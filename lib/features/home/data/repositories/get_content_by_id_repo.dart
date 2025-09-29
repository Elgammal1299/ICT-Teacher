import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/content_model.dart';

class GetcontentByIdRepo {
  final ApiService apiService;

  GetcontentByIdRepo(this.apiService);

  Future<Either<Failure,ContentModel >> getcontentById(String id ) async {
    try {
      final response = await apiService.getContentById(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
