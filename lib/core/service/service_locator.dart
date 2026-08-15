import 'package:get_it/get_it.dart';
import 'package:icd_teacher/features/home/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> ServiceLocator() async {
  sl.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance()
  );
  // ThemeCubit
  sl.registerLazySingleton<ThemeCubit>(() {
    return ThemeCubit();
  });
}
// void getdata(){
//   sl<SharedPreferences>().get
// }