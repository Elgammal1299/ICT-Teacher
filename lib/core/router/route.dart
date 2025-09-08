import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/DI/setup_get_it.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/pages/login_page.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/pages/register_page.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/grades_cubit/grades_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/regions_cubit/regions_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:icd_teacher/features/home/data/models/tram_grade_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/get_lesson_cubit/get_lesson_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/tram_grade_cubit/tram_grade_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:icd_teacher/features/home/presentation/pages/choose_terms_page.dart';
import 'package:icd_teacher/features/home/presentation/pages/home_page.dart';
import 'package:icd_teacher/features/nav_bar/ui/view/nav_bar.dart';
import 'package:icd_teacher/features/nav_bar/ui/view_model/nav_bar_cubit.dart';
import 'package:icd_teacher/features/onboarding/view/onboarding_page.dart';
import 'package:icd_teacher/features/splash_screen/splash_page.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboardingRouter:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case AppRoutes.splasahRouter:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.homeRoute:
        final args = settings.arguments as TermModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<UserDataCubit>()..userData(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<GetLessonCubit>()..getLesson(args.id, "lesson"),
              ),
            ],
            child: HomePage(termModel: args),
          ),
        );
      case AppRoutes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginPage(),
          ),
        );
      case AppRoutes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<RegisterCubit>()),
              BlocProvider(create: (context) => getIt<GradesCubit>()),
              BlocProvider(create: (context) => getIt<RegionsCubit>()),
            ],
            child: const RegisterPage(),
          ),
        );
      case AppRoutes.chooseTermsRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<UserDataCubit>()..userData(),
              ),
              BlocProvider(create: (context) => getIt<TramGradeCubit>()),
            ],
            child: const ChooseTermsPage(),
          ),
        );
      case AppRoutes.navBarScreenRoute:
        final args = settings.arguments as TermModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => NavBarCubit()),
              BlocProvider.value(value: getIt<UserDataCubit>()..userData()),
              BlocProvider(
                create: (context) =>
                    getIt<GetLessonCubit>()..getLesson(args.id, "lesson"),
              ),
            ],
            child: NavBarScreen(termModel: args),
          ),
        );

      default:
        return null;
    }
  }
}
