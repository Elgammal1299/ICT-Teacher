
import 'package:flutter/material.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_revisions_item.dart';

class CustomRevisionsListView extends StatelessWidget {
  const CustomRevisionsListView({super.key, required this.data});
  final List<LessonsModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CustomRevisionsItem(lessonsModel: data[index],),
        );
      },
    );
  }
}