import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/tram_grade_model.dart';

class CustomQuizListView extends StatelessWidget {
  const CustomQuizListView({super.key, required this.termModel});
  final TermModel termModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.quizMonthlyPageRoute,arguments: termModel,);
            },
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: AppColors.primary, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),

                child: Image.asset(AppImage.quizMonth, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,

              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: AppColors.primary, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),

                child: Image.asset(AppImage.quizWeek, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
