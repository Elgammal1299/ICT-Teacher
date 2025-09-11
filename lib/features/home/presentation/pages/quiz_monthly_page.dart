import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/quizzes_monthly_cubit/quizzes_monthly_cubit.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_tap_view.dart';

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

class CustomQuizMonthyListView extends StatelessWidget {
  const CustomQuizMonthyListView({super.key, required this.data});
  final List<LessonsModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CustomQuizMonthyItem(quizModel: data[index]),
        );
      },
    );
  }
}

class CustomQuizMonthyItem extends StatelessWidget {
  const CustomQuizMonthyItem({super.key, required this.quizModel});
  final LessonsModel quizModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(quizModel.title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Handle item tap, e.g., navigate to quiz details
        },
      ),
    );
  }
}
