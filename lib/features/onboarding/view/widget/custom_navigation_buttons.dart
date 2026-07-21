
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding: EdgeInsets.only(right: 24.r, left: 24.r, bottom: 16.h),
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
              SizedBox(width: 80.w),

            ElevatedButton(
              onPressed: onNextPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: onboardingModelList[currentPage].color,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                currentPage == onboardingModelList.length - 1
                    ? 'Get Started'
                    : 'Next',
                style: TextStyle(
                  fontSize: 16.sp,
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
