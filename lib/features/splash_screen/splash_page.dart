import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/constant/shared_preferences_key.dart';
import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
import 'package:icd_teacher/core/helper/user_session.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _controller;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video/splash.mp4')
      ..initialize().then((_) {
        if (!mounted) return;

        setState(() {});
        _controller.play();
      });

    _controller.addListener(() {
      if (!_controller.value.isInitialized) return;

      if (!_navigated &&
          _controller.value.position >= _controller.value.duration) {
        _navigated = true;
        _decideNavigation();
      }
    });
  }

  Future<void> _decideNavigation() async {
    if (!mounted) return;

    final isOnboardingCompleted = await SharedPrefHelper.getBool(
      SharedPreferencesKeys.onboarding,
    );

    if (!mounted) return;

    if (!isOnboardingCompleted) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboardingRouter);
    } else {
      final loggedIn = await UserSession.isLoggedIn();

      if (!mounted) return;

      if (loggedIn) {
        Navigator.pushReplacementNamed(context, AppRoutes.chooseTermsRoute);
      } else {
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
      backgroundColor: AppColors.background,
      body: _controller.value.isInitialized
          ? SafeArea(
              child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(AppImage.logo,height: 150,width: 150,),
                    // const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: AspectRatio(
                        
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      "أهلاً وسهلاً بكم\nتعلم التكنولوجيا... واصنع مستقبلك",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Amiri',
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                
                
                    
                  ],
                ),
              ),
            )
          : const ColoredBox(color: Colors.white, child: SizedBox.expand()),
    );
  }
}
