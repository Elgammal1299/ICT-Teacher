import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_lessons_list_view.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_no_lesson.dart';
import 'package:icd_teacher/features/lessons/ui/view_model/get_lesson_cubit/get_lesson_cubit.dart';

class LessonItemPage extends StatelessWidget {
  const LessonItemPage({super.key, required this.termModel});
  final TermModel termModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الدروس')),
      body: BlocBuilder<GetLessonCubit, GetLessonState>(
        builder: (context, state) {
          if (state is GetLessonLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetLessonError) {
            return Center(child: Text(state.errMessage));
          } else if (state is GetLessonSuccess) {
            final data = state.lessons;

            if (state.lessons.isEmpty) {
              return const CustomNoItem(title: 'لا يوجد دروس حتي الان ');
            }
            return CustomLessonsListView(data: data);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
