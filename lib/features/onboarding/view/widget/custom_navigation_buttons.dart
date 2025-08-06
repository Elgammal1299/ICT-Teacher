
import 'package:flutter/material.dart';
import 'package:icd_teacher/features/onboarding/data/model/onboarding_model.dart';

class CustomNavigationButtons extends StatelessWidget {
  final ValueNotifier<int> currentPageNotifier;
  final PageController pageController;
  final VoidCallback onNextPressed;

  const CustomNavigationButtons({
    super.key,
    required this.currentPageNotifier,
    required this.pageController,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ValueListenableBuilder<int>(
        valueListenable: currentPageNotifier,
        builder: (_, currentPage, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentPage > 0)
              TextButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Previous'),
              )
            else
              const SizedBox(width: 80),

            ElevatedButton(
              onPressed: onNextPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: onboardingModelList[currentPage].color,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: Text(
                currentPage == onboardingModelList.length - 1
                    ? 'Get Started'
                    : 'Next',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
