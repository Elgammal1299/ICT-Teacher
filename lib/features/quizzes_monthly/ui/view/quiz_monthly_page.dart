import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view/widget/custom_quiz_monthy_list_view.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view_model/quizzes_monthly_cubit/quizzes_monthly_cubit.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_no_lesson.dart';

class QuizMonthlyPage extends StatelessWidget {
  const QuizMonthlyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختبارات الشهرية'), centerTitle: true),
      body: BlocBuilder<QuizzesMonthyCubit, QuizzesMonthyState>(
        builder: (context, state) {
          if (state is QuizzesMonthyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizzesMonthyError) {
            return Center(child: Text(state.errMessage));
          } else if (state is QuizzesMonthySuccess) {
            final data = state.lessons;

            if (state.lessons.isEmpty) {
              return const CustomNoLesson();
            }
            return CustomQuizMonthyListView(data: data);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
