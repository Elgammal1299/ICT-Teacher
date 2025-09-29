import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view_model/answers_questions_cubit/answers_submit_cubit.dart';

class QuizPage extends StatefulWidget {
  final QuizModel quiz;

  const QuizPage({super.key, required this.quiz});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;
  int myTotalScore = 0;
  int answerChosen = -1;

  /// نخزن id السؤال -> id الإجابة المختارة
  final Map<String, String> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    final questions = widget.quiz.questions ?? [];

    return BlocConsumer<AnswersSubmitCubit, AnswersSubmitState>(
      listener: (context, state) {
        if (state is AnswersSubmitSuccess) {
          final serverScore = state.contentModel.score;
          final maxScore = questions.length;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  QuizResultPage(totalScore: serverScore, maxScore: maxScore),
            ),
          );
        } else if (state is AnswersSubmitError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("خطأ: ${state.errMessage}")));
        }
      },
      builder: (context, state) {
        if (state is AnswersSubmitLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (questions.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text(
                "لا يوجد اختبار حتي الآن",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }

        final currentQuestion = questions[questionIndex];
        final choices = currentQuestion.choices ?? [];

        return Scaffold(
          appBar: AppBar(title: Text(widget.quiz.title ?? 'Quiz')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  // السؤال
                  Text(
                    currentQuestion.body ?? '',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall!.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 20),

                  // الإجابات
                  Column(
                    children: List.generate(choices.length, (index) {
                      final choice = choices[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
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
                      );
                    }),
                  ),

                  const Spacer(),

                  // زر Next / Finish
                  CustomElevatedButton(
                    text: questionIndex + 1 < questions.length
                        ? 'Next'
                        : 'Finish',
                    onPressed: () {
                      if (answerChosen == -1) return;

                      // حفظ إجابة المستخدم
                      userAnswers[currentQuestion.id ?? ""] =
                          choices[answerChosen].id ?? "";

                      setState(() {
                        myTotalScore += 10;
                      });

                      if (questionIndex + 1 < questions.length) {
                        setState(() {
                          questionIndex += 1;
                          answerChosen = -1;
                        });
                      } else {
                        // تجهيز body للإرسال
                        final body = AnswersRequestModel(
                          answers: userAnswers.values.toList(),
                        );

                        // إرسال الإجابات
                        context.read<AnswersSubmitCubit>().getSubmit(
                          widget.quiz.id ?? "",
                          body,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class QuizResultPage extends StatelessWidget {
  final int totalScore;
  final int maxScore;

  const QuizResultPage({
    super.key,
    required this.totalScore,
    required this.maxScore,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (totalScore / maxScore * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(title: const Text('نتيجة الاختبار'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'لقد أنهيت الاختبار!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'درجتك: $totalScore / $maxScore',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'النسبة المئوية: $percentage%',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('العودة للصفحة الرئيسية'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
