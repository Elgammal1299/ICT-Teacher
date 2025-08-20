import 'package:flutter/material.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/pages/login_page.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/pages/register_page.dart';
import 'package:icd_teacher/features/home/presentation/pages/home_page.dart';
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
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      default:
        return null;
    }
  }
}
