import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/quizzes_weekly_cubit/quizzes_weekly_cubit.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_tap_view.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_no_lesson.dart';

class QuizWeeklyPage extends StatelessWidget {
  const QuizWeeklyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختبارات الشهرية'), centerTitle: true),
      body: BlocBuilder<QuizzesWeeklyCubit, QuizzesWeeklyState>(
        builder: (context, state) {
          if (state is QuizzesWeeklyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizzesWeeklyError) {
            return Center(child: Text(state.errMessage));
          } else if (state is QuizzesWeeklySuccess) {
            final data = state.lessons;

            if (state.lessons.isEmpty) {
              return const CustomNoLesson();
            }
            return CustomQuizWeeklyListView(data: data);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

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
