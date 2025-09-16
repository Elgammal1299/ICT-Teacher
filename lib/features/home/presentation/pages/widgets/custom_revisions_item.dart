import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';

class CustomRevisionsItem extends StatelessWidget {
  const CustomRevisionsItem({super.key, required this.lessonsModel});
  final LessonsModel lessonsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.secondary.withOpacity(0.1),
      ),
      width: double.infinity,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            // borderRadius: BorderRadius.circular(12),
            child: Container(
              color: AppColors.primary.withOpacity(0.1),
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(width: 12),
          Text(
            lessonsModel.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.lessonPageRoute,
                arguments: lessonsModel,
              );
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
