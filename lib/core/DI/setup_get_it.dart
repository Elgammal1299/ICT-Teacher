import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/core/service/dio_factory.dart';
import 'package:icd_teacher/features/auth/features/login/data/repositories/register_repo.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/register_cubit/register_cubit.dart';

/// This is the dependency injection file for the app.
final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio Instance
  Dio dio = await DioFactory.getDio();

  // ✅ Register ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  // ✅ Register UserDataRepo
  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(getIt<ApiService>()),
  );
  // ✅ Register Cubit
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<RegisterRepo>()),
  );
}
