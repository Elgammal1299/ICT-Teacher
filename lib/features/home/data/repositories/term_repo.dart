import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';

class TermRepo {
  final ApiService apiService;

  TermRepo(this.apiService);

  Future<Either<Failure, List<TermModel>>> getTermRepo() async {
    try {
      final response = await apiService.terms();
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
