import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/shared_preferences_key.dart';
import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/onboarding/data/model/onboarding_model.dart';
import 'package:icd_teacher/features/onboarding/view/widget/onboarding_body.dart';
import 'package:icd_teacher/features/onboarding/view/widget/custom_navigation_buttons.dart';
import 'package:icd_teacher/features/onboarding/view/widget/custom_page_indicator.dart';
import 'package:icd_teacher/features/onboarding/view/widget/custom_skip_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    _pageController.dispose();
    currentPageNotifier.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (currentPageNotifier.value < onboardingModelList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  void _completeOnboarding() async {
    await SharedPrefHelper.setData(SharedPreferencesKeys.onboarding, true);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// Skip Button
            CustomSkipButton(onPressed: _skipOnboarding),

            /// PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => currentPageNotifier.value = index,
                itemCount: onboardingModelList.length,
                itemBuilder: (context, index) =>
                    OnboardingBody(data: onboardingModelList[index]),
              ),
            ),

            /// Page Indicators
            CustomPageIndicator(currentPageNotifier: currentPageNotifier),

            /// Navigation Buttons
            CustomNavigationButtons(
              currentPageNotifier: currentPageNotifier,
              pageController: _pageController,
              onNextPressed: _nextPage,
            ),
          ],
        ),
      ),
    );
  }
}
