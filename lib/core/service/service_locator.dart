import 'package:get_it/get_it.dart';
import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> ServiceLocator() async {
  sl.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance()
  );
}
// void getdata(){
//   sl<SharedPreferences>().get
// }