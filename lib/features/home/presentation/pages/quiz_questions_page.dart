import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/quiz_cubit/quiz_cubit.dart';

class QuizQuestionsPage extends StatefulWidget {
  const QuizQuestionsPage({super.key, required this.quizModel});
  final LessonsModel quizModel;

  @override
  State<QuizQuestionsPage> createState() => _QuizQuestionsPageState();
}

class _QuizQuestionsPageState extends State<QuizQuestionsPage> {
  int questionIndex = 0;
  int answerChosen = -1;
  bool showTotalScore = false;

  final Map<String, String> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizSuccess) {
            final quiz = state.quiz;
            final questions = quiz.questions ?? [];

            if (questions.isEmpty) {
              return const Center(
                child: Text(
                  "لا يوجد اختبار حتى الآن",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            if (showTotalScore) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Congratulations!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      'Your total score is: ${userAnswers.length * 10}',
                      style: const TextStyle(fontSize: 22),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          questionIndex = 0;
                          answerChosen = -1;
                          showTotalScore = false;
                          userAnswers.clear();
                        });
                      },
                      child: Text(
                        'Reset Quiz',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              );
            }

            final currentQuestion = questions[questionIndex];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  /// السؤال
                  Text(
                    currentQuestion.body ?? '',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall!.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 20),

                  /// الإجابات
                  Column(
                    children: List.generate(
                      (currentQuestion.choices ?? []).length,
                      (index) {
                        final choice = currentQuestion.choices![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  answerChosen = index;
                                });
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: answerChosen == index
                                      ? Colors.green
                                      : Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 20,
                                        color: answerChosen == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      const SizedBox(width: 16.0),
                                      Text(
                                        choice.body ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: answerChosen == index
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const Spacer(),

                  /// زر Next / Finish
                  CustomElevatedButton(
                    text: questionIndex + 1 < questions.length
                        ? 'Next'
                        : 'Finish',
                    onPressed: () {
                      if (answerChosen == -1) return;

                      final selectedChoice =
                          currentQuestion.choices![answerChosen];

                      userAnswers[currentQuestion.id ?? ""] =
                          selectedChoice.id ?? "";

                      context.read<QuizCubit>().selectAnswer(
                        questionId: currentQuestion.id ?? '',
                        choiceId: selectedChoice.id ?? '',
                      );

                      if (questionIndex + 1 < questions.length) {
                        setState(() {
                          questionIndex += 1;
                          answerChosen = -1;
                        });
                      } else {
                        setState(() {
                          showTotalScore = true;
                        });

                        // هنا ممكن تستدعي submitQuiz
                        // context.read<QuizCubit>().submitQuiz();
                        print("User answers: $userAnswers");
                      }
                    },
                  ),
                ],
              ),
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
