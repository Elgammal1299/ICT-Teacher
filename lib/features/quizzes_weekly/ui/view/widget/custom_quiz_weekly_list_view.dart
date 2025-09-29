
import 'package:flutter/material.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/quizzes_weekly/ui/view/widget/custom_quiz_weekly_item.dart';

class CustomQuizWeeklyListView extends StatelessWidget {
  const CustomQuizWeeklyListView({super.key, required this.data});
  final List<LessonsModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CustomQuizWeeklyItem(quizModel: data[index]),
        );
      },
    );
  }
}
