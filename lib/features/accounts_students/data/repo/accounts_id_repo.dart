import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/accounts_students/data/model/accounts_id_model.dart';

class AccountsIdRepo {
  final ApiService apiService;

  AccountsIdRepo(this.apiService);

  Future<Either<Failure, AccountsIdModel>> getAccountsId(String id) async {
    try {
      final response = await apiService.accountsId(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
