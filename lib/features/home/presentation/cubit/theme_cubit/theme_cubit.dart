import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/service/service_locator.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';


class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    final isDark = sl.get<SharedPreferences>().getBool('isDark') ?? false;
    emit(ThemeChanged(isDark));
  }

  void changeTheme() {
    final currentTheme =
        state is ThemeChanged ? (state as ThemeChanged).isDark : false;
    final newTheme = !currentTheme;

    emit(ThemeChanged(newTheme));
    sl.get<SharedPreferences>().setBool('isDark', newTheme);
  }
}