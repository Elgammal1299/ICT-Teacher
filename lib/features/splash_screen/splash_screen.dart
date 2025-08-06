import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/constant/shared_preferences_key.dart';
import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
import 'package:icd_teacher/core/router/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3)); // ندي وقت للانيميشن

    final isOnboardingCompleted = await SharedPrefHelper.getBool(
      SharedPreferencesKeys.onboarding,
    );

    if (!mounted) return;

    if (isOnboardingCompleted) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.onboardingRouter);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Colors.green,
                child: Image.asset(
                  AppImage.splashImage,
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'ICD Teacher',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Empowering Educators',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
