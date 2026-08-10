import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/error/failure.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/features/home/data/local/user_local_data_source.dart';
import 'package:icd_teacher/features/home/data/models/user_model.dart';

class UserRepo {
  final ApiService apiService;
  final UserLocalDataSource localDataSource;

  UserRepo(this.apiService, this.localDataSource);

  Future<Either<Failure, UserModel>> userData() async {
    try {
      // 1️⃣ جرّب الـ API أولاً
      final response = await apiService.user();
      // 2️⃣ احفظ البيانات محلياً لو نجح الطلب
      await localDataSource.saveUser(response);
      return Right(response);
    } on DioException catch (e) {
      // 3️⃣ لو فشل — جرّب الـ Cache المحلي
      final cached = await localDataSource.getUser();
      if (cached != null) {
        return Right(cached);
      }
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      // 4️⃣ لو فشل بخطأ عام — جرّب الـ Cache المحلي
      final cached = await localDataSource.getUser();
      if (cached != null) {
        return Right(cached);
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

