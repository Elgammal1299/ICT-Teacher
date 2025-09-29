
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view_model/answers_questions_cubit/answers_submit_cubit.dart';
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
  final Map<String, String> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: BlocListener<AnswersSubmitCubit, AnswersSubmitState>(
        listener: (context, state) {
          if (state is AnswersSubmitSuccess) {
            // الانتقال لصفحة النتيجة
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => QuizResultPage(result: state.contentModel),
              ),
            );
          } else if (state is AnswersSubmitError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        child: BlocBuilder<QuizCubit, QuizState>(
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

                        // حفظ إجابة المستخدم
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
                          // إرسال كل الإجابات مرة واحدة عند الانتهاء
                          final answersList = userAnswers.entries
                              .map((e) => e.value) // ناخد الـ choice_id فقط
                              .toList();

                          final answersBody = AnswersRequestModel(
                            answers: answersList,
                          );

                          context.read<AnswersSubmitCubit>().getSubmit(
                            widget.quizModel.id,
                            answersBody,
                          );

                          context.read<AnswersSubmitCubit>().getSubmit(
                            widget.quizModel.id,
                            answersBody,
                          );
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
      ),
    );
  }
}

class QuizResultPage extends StatelessWidget {
  final AnswersQuestionsModel result;

  const QuizResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Your Score: ${result.score}",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: result.questions.length,
                itemBuilder: (context, index) {
                  final q = result.questions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(q.body),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: q.choices.map((c) {
                          return Row(
                            children: [
                              Icon(
                                c.isAnswered
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: c.isCorrect ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(c.body),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
