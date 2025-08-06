import 'package:flutter/material.dart';
import 'package:icd_teacher/features/onboarding/data/model/onboarding_model.dart';

class CustomPageIndicator extends StatelessWidget {
  final ValueNotifier<int> currentPageNotifier;

  const CustomPageIndicator({super.key, required this.currentPageNotifier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ValueListenableBuilder<int>(
        valueListenable: currentPageNotifier,
        builder: (_, currentPage, __) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onboardingModelList.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: currentPage == index ? 20.0 : 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? onboardingModelList[currentPage].color
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
