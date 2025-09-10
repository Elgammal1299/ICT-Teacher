import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';

class CustomLessonItem extends StatelessWidget {
  const CustomLessonItem({super.key, required this.lessonsModel});
  final LessonsModel lessonsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.lessonPageRoute,
          arguments: lessonsModel,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.secondary.withOpacity(0.1),
        ),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.secondary,
              ),

              child: SvgPicture.asset(
                AppImage.book,
                width: 24,
                height: 24,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              lessonsModel.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(AppImage.backIconNotBorser),
          ],
        ),
      ),
    );
  }
}
