import 'package:flutter/material.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';

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
  bool showTotalScore = false;

  /// هنا بنخزن اجابات المستخدم: questionId -> choiceId
  final Map<String, String> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    final questions = widget.quiz.questions ?? [];
    final resultedScore = questions.length * 10;
    showTotalScore = myTotalScore >= resultedScore;

    return Scaffold(
      appBar: AppBar(title: Text(widget.quiz.title ?? 'Quiz')),
      body: SafeArea(
        child: questions.isEmpty
            ? const Center(child: Text("No questions available"))
            : !showTotalScore
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),

                        /// السؤال
                        Text(
                          questions[questionIndex].body ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 20),

                        /// الإجابات
                        Column(
                          children: List.generate(
                            (questions[questionIndex].choices ?? []).length,
                            (index) {
                              final choice =
                                  questions[questionIndex].choices![index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
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
                                        border:
                                            Border.all(color: Colors.black12),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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

                        /// زر Next
                        CustomElevatedButton(
                          text: questionIndex + 1 < questions.length
                              ? 'Next'
                              : 'Finish',
                          onPressed: () {
                            if (answerChosen == -1) return;

                            final currentQuestion = questions[questionIndex];
                            final selectedChoice =
                                currentQuestion.choices![answerChosen];

                            // نخزن id السؤال و id الإجابة المختارة
                            userAnswers[currentQuestion.id ?? ""] =
                                selectedChoice.id ?? "";

                            if (questionIndex + 1 < questions.length) {
                              setState(() {
                                questionIndex += 1;
                                answerChosen = -1;
                              });
                            } else {
                              setState(() {
                                showTotalScore = true;
                              });

                              /// هنا تقدر تبعت الاجابات للسيرفر
                              print("User answers: $userAnswers");
                            }

                            setState(() {
                              myTotalScore += 10;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : Center(
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
                          'Your total score is: $myTotalScore',
                          style: const TextStyle(fontSize: 22),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              questionIndex = 0;
                              myTotalScore = 0;
                              showTotalScore = false;
                              answerChosen = -1;
                              userAnswers.clear();
                            });
                          },
                          child: Text(
                            'Reset Quiz',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
