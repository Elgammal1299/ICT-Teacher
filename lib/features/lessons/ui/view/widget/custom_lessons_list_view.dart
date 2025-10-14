import 'package:flutter/widgets.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_lesson_item.dart';

class CustomLessonsListView extends StatelessWidget {
  const CustomLessonsListView({super.key, required this.data});
  final List<LessonsModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: CustomLessonItem(lessonsModel: data[index]),
        );
      },
    );
  }
}
