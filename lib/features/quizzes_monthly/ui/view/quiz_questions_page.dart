import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/error/error_state_widget.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
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
  
  // Track selected choice IDs for MCQ questions (supports multi-select)
  final Map<String, Set<String>> userMcqAnswers = {};

  // Track text answers for Essay questions
  final Map<String, String> userEssayAnswers = {};

  // Controller for essay text input
  final TextEditingController _essayController = TextEditingController();

  @override
  void dispose() {
    _essayController.dispose();
    super.dispose();
  }

  void _syncEssayControllerForCurrentQuestion(QuestionModel question) {
    final qId = question.id ?? '';
    _essayController.text = userEssayAnswers[qId] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.quizModel.title)),
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

              // If the student has an existing submission for this quiz, open results immediately
              if (quiz.submission != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizResultPage(result: quiz.submission!),
                      ),
                    );
                  }
                });
                return const Center(child: CircularProgressIndicator());
              }

              final questions = quiz.questions ?? [];

              if (questions.isEmpty) {
                return const CustomNoItem(title: 'لا يوجد اختبارات حتي الان ');
              }

              final currentQuestion = questions[questionIndex];
              final qId = currentQuestion.id ?? '';
              final isEssay = (currentQuestion.questionType ?? '').toLowerCase() == 'essay';
              final isMultiple = currentQuestion.multiple ?? false;

              final currentSelectedChoices = userMcqAnswers[qId] ?? <String>{};

              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Question body container
                            Container(
                              padding: EdgeInsets.all(16.w),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (currentQuestion.body ?? '').replaceAll(r'$', '\n'),
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  if (isMultiple)
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Text(
                                        '(يمكنك اختيار أكثر من إجابة)',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20.h),

                            /// Render choices for MCQ or TextFormField for Essay
                            if (isEssay) ...[
                              Text(
                                'اكتب إجابتك هنا:',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(height: 10.h),
                              TextFormField(
                                controller: _essayController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'أدخل الإجابة المقالية...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                onChanged: (val) {
                                  userEssayAnswers[qId] = val.trim();
                                },
                              ),
                            ] else ...[
                              Column(
                                children: List.generate(
                                  (currentQuestion.choices ?? []).length,
                                  (index) {
                                    final choice = currentQuestion.choices![index];
                                    final cId = choice.id ?? '';
                                    final isSelected = currentSelectedChoices.contains(cId);

                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (isMultiple) {
                                              final set = userMcqAnswers[qId] ?? <String>{};
                                              if (set.contains(cId)) {
                                                set.remove(cId);
                                              } else {
                                                set.add(cId);
                                              }
                                              userMcqAnswers[qId] = set;
                                            } else {
                                              userMcqAnswers[qId] = {cId};
                                            }
                                          });
                                        },
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: isSelected
                                                  ? Theme.of(context).primaryColor
                                                  : Colors.black12,
                                              width: isSelected ? 2.w : 1.w,
                                            ),
                                            borderRadius: BorderRadius.circular(8.r),
                                            color: isSelected
                                                ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                                                : Theme.of(context).cardColor,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(16.w),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  isMultiple
                                                      ? (isSelected ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded)
                                                      : (isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded),
                                                  size: 20.r,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                                SizedBox(width: 16.w),
                                                Expanded(
                                                  child: Text(
                                                    (choice.body ?? '').replaceAll(r'$', '\n'),
                                                    style: Theme.of(context).textTheme.titleMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],

                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Next / Submit button
                    CustomElevatedButton(
                      text: questionIndex + 1 < questions.length ? 'التالى' : 'انتهاء',
                      onPressed: () {
                        // Advance to next question or submit quiz
                        if (questionIndex + 1 < questions.length) {
                          setState(() {
                            questionIndex++;
                            final nextQ = questions[questionIndex];
                            _syncEssayControllerForCurrentQuestion(nextQ);
                          });
                        } else {
                          // Build SubmissionCreateRequest answer items
                          final List<AnswerItem> answerItems = [];

                          for (final q in questions) {
                            final questionId = q.id ?? '';
                            final qIsEssay = (q.questionType ?? '').toLowerCase() == 'essay';

                            if (qIsEssay) {
                              final txt = userEssayAnswers[questionId];
                              if (txt != null && txt.isNotEmpty) {
                                answerItems.add(AnswerItem(question: questionId, text: txt));
                              }
                            } else {
                              final choicesSet = userMcqAnswers[questionId];
                              if (choicesSet != null && choicesSet.isNotEmpty) {
                                answerItems.add(AnswerItem(question: questionId, choices: choicesSet.toList()));
                              }
                            }
                          }

                          final answersBody = AnswersRequestModel(answers: answerItems);
                          final targetQuizId = quiz.id ?? widget.quizModel.id;

                          context.read<AnswersSubmitCubit>().getSubmit(
                                targetQuizId,
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
