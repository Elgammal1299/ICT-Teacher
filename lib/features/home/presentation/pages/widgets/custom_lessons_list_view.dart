
import 'package:flutter/widgets.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_lesson_item.dart';

class CustomLessonsListView extends StatelessWidget {
  const CustomLessonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CustomLessonItem(),
        );
      },
    );
  }
}
