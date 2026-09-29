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
      List<RegionModel> regionsList = [];
      if (response is List) {
        regionsList = response.map((e) => RegionModel.fromJson(e as Map<String, dynamic>)).toList();
      } else if (response is Map<String, dynamic> && response['results'] is List) {
        regionsList = (response['results'] as List)
            .map((e) => RegionModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return Right(regionsList);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
