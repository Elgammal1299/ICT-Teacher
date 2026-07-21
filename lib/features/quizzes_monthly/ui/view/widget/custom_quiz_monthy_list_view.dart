
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view/widget/custom_quiz_monthy_item.dart';

class CustomQuizMonthyListView extends StatelessWidget {
  const CustomQuizMonthyListView({super.key, required this.data});
  final List<LessonsModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0.w),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: CustomQuizMonthyItem(quizModel: data[index]),
        );
      },
    );
  }
}
