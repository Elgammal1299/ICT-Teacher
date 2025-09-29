import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/accounts_students/data/model/accounts_model.dart';

class AccountsRepo {
  final ApiService apiService;

  AccountsRepo(this.apiService);

  Future<Either<Failure, List<AccountsModel>>> getAccounts() async {
    try {
      final response = await apiService.accounts();
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
