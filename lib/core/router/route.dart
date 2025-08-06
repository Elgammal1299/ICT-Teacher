import 'package:flutter/material.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/presentation/pages/home_screen.dart';
import 'package:icd_teacher/features/onboarding/view/onboarding_screen.dart';
import 'package:icd_teacher/features/splash_screen/splash_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboardingRouter:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.splasahRouter:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return null;
    }
  }
}
