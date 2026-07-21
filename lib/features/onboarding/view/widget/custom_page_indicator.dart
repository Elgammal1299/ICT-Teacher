import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/features/onboarding/data/model/onboarding_model.dart';

class CustomPageIndicator extends StatelessWidget {
  final ValueNotifier<int> currentPageNotifier;

  const CustomPageIndicator({super.key, required this.currentPageNotifier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: ValueListenableBuilder<int>(
        valueListenable: currentPageNotifier,
        builder: (_, currentPage, __) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onboardingModelList.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: currentPage == index ? 20.w : 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? onboardingModelList[currentPage].color
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
