import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/constant/shared_preferences_key.dart';
import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
import 'package:icd_teacher/core/helper/user_session.dart';
import 'package:icd_teacher/core/router/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
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

    _decideNavigation();
  }

  Future<void> _decideNavigation() async {
    // Wait for animation
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Check onboarding status
    final isOnboardingCompleted = await SharedPrefHelper.getBool(
      SharedPreferencesKeys.onboarding,
    );

    if (!isOnboardingCompleted) {
      // First time: Show onboarding
      Navigator.pushReplacementNamed(context, AppRoutes.onboardingRouter);
    } else {
      // Check if user is logged in
      final loggedIn = await UserSession.isLoggedIn();

      if (!mounted) return;

      if (loggedIn) {
        // User logged in: Go to choose terms
        Navigator.pushReplacementNamed(context, AppRoutes.chooseTermsRoute);
      } else {
        // User not logged in: Go to login
        Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
      }
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
      body: Stack(
        children: [
          // Background with decorative elements
          Container(
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: SvgPicture.asset(AppImage.appLogoFram37, width: 150),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SvgPicture.asset(AppImage.appLogoFram38, width: 150),
                ),
              ],
            ),
          ),

          // Center logo with animation
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: SvgPicture.asset(
                AppImage.splashImage,
                width: 200,
                height: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
