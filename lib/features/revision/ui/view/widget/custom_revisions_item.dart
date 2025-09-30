import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';

class CustomRevisionsItem extends StatelessWidget {
  const CustomRevisionsItem({super.key, required this.lessonsModel});
  final LessonsModel lessonsModel;

  @override
  Widget build(BuildContext context) {
    const Color cardBackground = Color(0xFFF8FBFE); // Soft blue-white
    const Color iconBackground = Color(0xFFE3F2FD); // Light blue
    const Color iconColor = Color(0xFF1976D2); // Medium blue
    const Color textColor = Color(0xFF1A237E); // Deep blue
    const Color arrowBackground = Color(0xFFF3E5F5); // Light purple
    const Color arrowColor = Color(0xFF7B1FA2); // Purple
    const Color borderColor = Color(0xFFE1F5FE); // Very light blue border

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.lessonPageRoute,
          arguments: lessonsModel,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: cardBackground,
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: iconBackground,
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                AppImage.book,
                width: 28,
                height: 28,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                lessonsModel.title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  letterSpacing: 0.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: arrowBackground,
                boxShadow: [
                  BoxShadow(
                    color: arrowColor.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                AppImage.backIconNotBorser,
                color: arrowColor,
                width: 18,
                height: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
