import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/error/error_state_widget.dart';
import 'package:icd_teacher/features/quizzes_weekly/ui/view/widget/custom_quiz_weekly_list_view.dart';
import 'package:icd_teacher/features/quizzes_weekly/ui/view_model/quizzes_weekly_cubit/quizzes_weekly_cubit.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_no_lesson.dart';

class QuizWeeklyPage extends StatelessWidget {
  const QuizWeeklyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقييمات الاسبوعية',),
      ),
      body: BlocBuilder<QuizzesWeeklyCubit, QuizzesWeeklyState>(
        builder: (context, state) {
          if (state is QuizzesWeeklyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizzesWeeklyError) {
            return ErrorStateWidget(
    message: state.errMessage,
  );
          } else if (state is QuizzesWeeklySuccess) {
            final data = state.lessons;

            if (state.lessons.isEmpty) {
              return const CustomNoItem(
                title: 'لا يوجد اختبارات اسبوعية حتي الان ',
              );
            }
            return CustomQuizWeeklyListView(data: data);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
