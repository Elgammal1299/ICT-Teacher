import 'package:flutter/material.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';

class CustomQuizWeeklyItem extends StatelessWidget {
  const CustomQuizWeeklyItem({super.key, required this.quizModel});
  final LessonsModel quizModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(quizModel.title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.quizQuestionsPageRoute,
            arguments: quizModel,
          );
        },
      ),
    );
  }
}
