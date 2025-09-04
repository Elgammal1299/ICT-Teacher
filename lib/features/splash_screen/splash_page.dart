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
    _checkUser();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    _navigateAfterDelay();
  }

  Future<void> _checkUser() async {
    final loggedIn = await UserSession.isLoggedIn();
    if (loggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.navBarScreenRoute);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
    }
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 5)); // ندي وقت للانيميشن

    final isOnboardingCompleted = await SharedPrefHelper.getBool(
      SharedPreferencesKeys.onboarding,
    );

    if (!mounted) return;

    if (isOnboardingCompleted) {
      // Navigator.pushReplacementNamed(context, AppRoutes.chooseTermsRoute);
      Navigator.pushReplacementNamed(context, AppRoutes.registerRoute);
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
      body: Stack(
        children: [
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
