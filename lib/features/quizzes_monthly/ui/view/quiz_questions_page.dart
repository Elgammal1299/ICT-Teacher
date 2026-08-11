import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/error/error_state_widget.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_no_lesson.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view/quiz_result_page.dart';
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
      appBar: AppBar(
        title: Text(widget.quizModel.title, )),
      body: BlocListener<AnswersSubmitCubit, AnswersSubmitState>(
        listener: (context, state) {
          if (state is AnswersSubmitSuccess) {
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
                return CustomNoItem(title: 'لا يوجد اختبارات حتي الان ');
              }

              final currentQuestion = questions[questionIndex];

              return Padding(
  padding: EdgeInsets.all(16.w),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ========================================
      // السؤال + الإجابات = Scrollable
      // ========================================
      Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// السؤال
              Container(
                padding: EdgeInsets.all(16.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Text(
                  (currentQuestion.body ?? '')
                      .replaceAll(r'$', '\n'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              SizedBox(height: 20.h),

              /// الإجابات
              Column(
                children: List.generate(
                  (currentQuestion.choices ?? []).length,
                  (index) {
                    final choice =
                        currentQuestion.choices![index];

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                      ),
                      child: SizedBox(
                        height: 60.h,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              answerChosen = index;
                            });
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                              borderRadius:
                                  BorderRadius.circular(8.r),
                              color: answerChosen == index
                                  ? Colors.green
                                  : Theme.of(context)
                                      .cardColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle_outlined,
                                    size: 20.r,
                                    color: answerChosen == index
                                        ? Colors.black
                                        : Theme.of(context)
                                            .primaryColor,
                                  ),

                                  SizedBox(width: 16.w),

                                  Expanded(
                                    child: Text(
                                      (choice.body ?? '')
                                          .replaceAll(
                                        r'$',
                                        '\n',
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
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

              // مساحة صغيرة في آخر الـ Scroll
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),

      SizedBox(height: 12.h),

      // ========================================
      // زر Next / Finish ثابت تحت
      // ========================================
      CustomElevatedButton(
        text: questionIndex + 1 < questions.length
            ? 'التالى'
            : 'انتهاء',
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
              questionIndex++;
              answerChosen = -1;
            });
          } else {
            // إرسال كل الإجابات مرة واحدة عند الانتهاء
            final answersList = userAnswers.entries
                .map((e) => e.value)
                .toList();

            final answersBody = AnswersRequestModel(
              answers: answersList,
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
              return ErrorStateWidget(message: state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
