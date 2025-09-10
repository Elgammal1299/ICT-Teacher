import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:icd_teacher/core/service/api_service.dart';
import 'package:icd_teacher/core/service/dio_factory.dart';
import 'package:icd_teacher/features/auth/features/login/data/repositories/grades_repo.dart';
import 'package:icd_teacher/features/auth/features/login/data/repositories/login_repo.dart';
import 'package:icd_teacher/features/auth/features/login/data/repositories/region_repo.dart';
import 'package:icd_teacher/features/auth/features/login/data/repositories/register_repo.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/grades_cubit/grades_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/regions_cubit/regions_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:icd_teacher/features/home/data/repositories/getcontent_by_id_repo.dart';
import 'package:icd_teacher/features/home/data/repositories/lesson_repo.dart';
import 'package:icd_teacher/features/home/data/repositories/revisions_repo.dart';
import 'package:icd_teacher/features/home/data/repositories/tram_grade_repo.dart';
import 'package:icd_teacher/features/home/data/repositories/user_repo.dart';
import 'package:icd_teacher/features/home/presentation/cubit/get_content_by_id_cubit/get_content_by_id_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/get_lesson_cubit/get_lesson_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/get_revisions_cubit/get_revisions_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/tram_grade_cubit/tram_grade_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/user_data_cubit/user_data_cubit.dart';

/// This is the dependency injection file for the app.
final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio Instance
  Dio dio = await DioFactory.getDio();

  // ✅ Register ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  //==============================
  // ✅ Register RegisterRepo
  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(getIt<ApiService>()),
  );
  // ✅ Register Cubit
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<RegisterRepo>()),
  );
  //==============================
  // ✅ Register loginRepo
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt<ApiService>()));
  // ✅ Register login Cubit
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepo>()));
  //==============================
  // ✅ Register UserDataRepo
  getIt.registerLazySingleton<UserRepo>(() => UserRepo(getIt<ApiService>()));
  // ✅ Register UserDataCubit
  getIt.registerFactory<UserDataCubit>(() => UserDataCubit(getIt<UserRepo>()));
  //=========================
  // ✅ Register grades Repo
  getIt.registerLazySingleton<GradesRepo>(
    () => GradesRepo(getIt<ApiService>()),
  );
  // ✅ Register GradesCubit
  getIt.registerFactory<GradesCubit>(() => GradesCubit(getIt<GradesRepo>()));
  //=========================
  // ✅ Register Regions Repo
  getIt.registerLazySingleton<RegionRepo>(
    () => RegionRepo(getIt<ApiService>()),
  );
  // ✅ Register RegionsCubit
  getIt.registerFactory<RegionsCubit>(() => RegionsCubit(getIt<RegionRepo>()));
  //=========================
  // ✅ Register Term Greade Repo
  getIt.registerLazySingleton<TramGradeRepo>(
    () => TramGradeRepo(getIt<ApiService>()),
  );
  // ✅ Register Term Greade Cubit
  getIt.registerFactory<TramGradeCubit>(
    () => TramGradeCubit(getIt<TramGradeRepo>()),
  );
  //=========================
  // ✅ Register Term lesson Repo
  getIt.registerLazySingleton<LessonRepo>(
    () => LessonRepo(getIt<ApiService>()),
  );
  // ✅ Register Term Lesson Cubit
  getIt.registerFactory<GetLessonCubit>(
    () => GetLessonCubit(getIt<LessonRepo>()),
  );
  //=========================
  // ✅ Register Term Revesion Repo
  getIt.registerLazySingleton<RevisionsRepo>(
    () => RevisionsRepo(getIt<ApiService>()),
  );
  // ✅ Register Term Lesson Cubit
  getIt.registerFactory<GetRevisionsCubit>(
    () => GetRevisionsCubit(getIt<RevisionsRepo>()),
  );
  //=========================
  // ✅ Register Term Content Repo
  getIt.registerLazySingleton<GetcontentByIdRepo>(
    () => GetcontentByIdRepo(getIt<ApiService>()),
  );
  // ✅ Register Term GetContentByIdCubit
  getIt.registerFactory<GetContentByIdCubit>(
    () => GetContentByIdCubit(getIt<GetcontentByIdRepo>()),
  );
}
