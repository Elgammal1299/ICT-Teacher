import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/region_model.dart';

class RegionRepo {
  final ApiService apiService;

  RegionRepo(this.apiService);

  Future<Either<Failure, List<RegionModel>>> regions() async {
    try {
      final response = await apiService.regions();
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
