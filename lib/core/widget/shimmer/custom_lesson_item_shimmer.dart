import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomLessonItemShimmer extends StatelessWidget {
  const CustomLessonItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: SizedBox(
        height: 85,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            /// المستطيل
            Positioned(
              left: 0,
              right: 0,
              child: Shimmer(
                duration: const Duration(milliseconds: 1500),
                color: Colors.white,
                colorOpacity: 0.35,
                child: Container(
                  height: 75,
                  decoration: const BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  padding: const EdgeInsets.only(right: 75),
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 170,
                    height: 18,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.35),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),

            /// الدائرة
            Shimmer(
              duration: const Duration(milliseconds: 1500),
              color: Colors.white,
              colorOpacity: 0.35,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.border,
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppColors.border.withOpacity(.25),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}