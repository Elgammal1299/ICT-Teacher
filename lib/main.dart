import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:icd_teacher/bloc_observer.dart';
import 'package:icd_teacher/core/DI/setup_get_it.dart';
import 'package:icd_teacher/core/constant/app_theme.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/router/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/features/home/presentation/cubit/theme_cubit/theme_cubit.dart';

// Global navigator key for navigation from anywhere in the app
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  Bloc.observer = MyBlocObserver();
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: ScreenUtilInit(
        designSize: Size(402, 874),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        ensureScreenSize: true,
        enableScaleText: () => true,
        builder: (context, child) {
          return IcdTeacherApp();
        },
      ),
    ),
  );
}

class IcdTeacherApp extends StatelessWidget {
  const IcdTeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state is ThemeChanged ? state.isDark : false;
        return MaterialApp(
          navigatorKey: navigatorKey,
          locale: const Locale('ar'),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [const Locale('ar')],
          debugShowCheckedModeBanner: false,
          title: 'ICT Teacher',
          initialRoute: AppRoutes.splasahRouter,
          onGenerateRoute: AppRouter.generateRoute,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
