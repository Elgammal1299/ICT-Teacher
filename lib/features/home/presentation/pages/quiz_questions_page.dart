import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/quiz_cubit/quiz_cubit.dart';

class QuizQuestionsPage extends StatelessWidget {
  const QuizQuestionsPage({super.key, required this.quizModel});
  final LessonsModel quizModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizSuccess) {
            final quiz = state.quiz; // QuizModel
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  quiz.title ?? "Quiz",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // عرض الأسئلة
                ...quiz.questions!.map((q) {
                  final selectedChoiceId =
                      state.selectedAnswers[q.id]; // الخانة المختارة
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            q.body ?? 'dsf',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...q.choices!.map(
                            (c) => RadioListTile<String>(
                              title: Text(c.body ?? ''),
                              value: c.id ?? '',
                              groupValue: selectedChoiceId,
                              onChanged: (val) {
                                context.read<QuizCubit>().selectAnswer(
                                  questionId: q.id ?? '',
                                  choiceId: c.id ?? '',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // context.read<QuizCubit>().submitQuiz();
                  },
                  child: const Text("إرسال الإجابات"),
                ),
              ],
            );
          } else if (state is QuizError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
