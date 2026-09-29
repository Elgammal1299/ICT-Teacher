import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/error/error_state_widget.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/quiz_cubit/quiz_cubit.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_no_lesson.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view/quiz_result_page.dart';

/// Screen for taking a quiz.
/// Built as a pure [StatelessWidget] adhering to strict Cubit-driven architecture:
/// - All state (question index, selections, essay inputs, submission) is driven by [QuizCubit].
/// - Listens to [QuizSubmitted] to redirect to [QuizResultPage] (both for initial attempt detection and post-submission).
/// - Supports MCQ single-choice, MCQ multi-choice, and Essay multiline inputs.
/// - Supports forward ("التالى") and backward ("السابق") navigation, preserving all inputs.
/// - Prevents accidental double submission via loading state.
class QuizQuestionsPage extends StatelessWidget {
  final String quizId;
  final String quizTitle;

  const QuizQuestionsPage({
    super.key,
    required this.quizId,
    this.quizTitle = 'الاختبار',
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) {
        if (state is QuizSubmitted) {
          // Immediately redirect to results if submission is detected or created
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => QuizResultPage(result: state.result),
            ),
          );
        } else if (state is QuizInProgress && state.submissionError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.submissionError!),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is QuizLoading || state is QuizInitial) {
          return Scaffold(
            appBar: AppBar(title: Text(quizTitle)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is QuizError) {
          return Scaffold(
            appBar: AppBar(title: Text(quizTitle)),
            body: ErrorStateWidget(message: state.errMessage),
          );
        }

        if (state is QuizInProgress) {
          final questions = state.quiz.questions ?? [];

          if (questions.isEmpty) {
            return Scaffold(
              appBar: AppBar(title: Text(state.quiz.title ?? quizTitle)),
              body: const CustomNoItem(title: 'لا يوجد أسئلة في هذا الاختبار حالياً'),
            );
          }

          final currentQ = state.currentQuestion;
          if (currentQ == null) {
            return Scaffold(
              appBar: AppBar(title: Text(state.quiz.title ?? quizTitle)),
              body: const Center(child: Text('السؤال غير متوفر')),
            );
          }

          final qId = currentQ.id ?? '';
          final isEssay = (currentQ.questionType ?? '').toLowerCase() == 'essay';
          final isMultiple = currentQ.multiple ?? false;
          final selectedChoices = state.mcqAnswers[qId] ?? <String>{};

          return Scaffold(
            appBar: AppBar(
              title: Text(state.quiz.title ?? quizTitle),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question progress indicator header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            'السؤال ${state.currentQuestionIndex + 1} من ${state.totalQuestions}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        if (currentQ.points != null && currentQ.points! > 0)
                          Text(
                            '${currentQ.points} درجات',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Scrollable content area
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Question Card
                            _QuestionCard(
                              question: currentQ,
                              isMultiple: isMultiple,
                            ),
                            SizedBox(height: 20.h),

                            // Question Answer Input (Essay multiline or MCQ choice tiles)
                            if (isEssay)
                              _EssayAnswerField(
                                key: ValueKey('essay_$qId'),
                                questionId: qId,
                                initialText: state.essayAnswers[qId] ?? '',
                              )
                            else
                              Column(
                                children: List.generate(
                                  (currentQ.choices ?? []).length,
                                  (index) {
                                    final choice = currentQ.choices![index];
                                    final cId = choice.id ?? '';
                                    final isSelected = selectedChoices.contains(cId);

                                    return _ChoiceTile(
                                      choice: choice,
                                      isSelected: isSelected,
                                      isMultiple: isMultiple,
                                      onTap: () {
                                        context.read<QuizCubit>().selectMcqChoice(
                                              questionId: qId,
                                              choiceId: cId,
                                              isMultiple: isMultiple,
                                            );
                                      },
                                    );
                                  },
                                ),
                              ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Navigation buttons (Previous / Next / Submit)
                    _NavigationButtonsRow(state: state),
                  ],
                ),
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

/// Widget displaying question text, instructions, and optional figure image
class _QuestionCard extends StatelessWidget {
  final QuestionModel question;
  final bool isMultiple;

  const _QuestionCard({
    required this.question,
    required this.isMultiple,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (question.body ?? '').replaceAll(r'$', '\n'),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (isMultiple)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                '(يمكنك اختيار أكثر من إجابة صحيحة)',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ),
          if (question.figure != null && question.figure!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  question.figure!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget managing essay text input and synchronizing directly with [QuizCubit]
class _EssayAnswerField extends StatefulWidget {
  final String questionId;
  final String initialText;

  const _EssayAnswerField({
    super.key,
    required this.questionId,
    required this.initialText,
  });

  @override
  State<_EssayAnswerField> createState() => _EssayAnswerFieldState();
}

class _EssayAnswerFieldState extends State<_EssayAnswerField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اكتب إجابتك هنا:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: _controller,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'أدخل إجابتك المقالية بالتفصيل...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
          ),
          onChanged: (val) {
            context.read<QuizCubit>().updateEssayAnswer(
                  questionId: widget.questionId,
                  text: val,
                );
          },
        ),
      ],
    );
  }
}

/// Single MCQ Choice selectable tile
class _ChoiceTile extends StatelessWidget {
  final ChoiceModel choice;
  final bool isSelected;
  final bool isMultiple;
  final VoidCallback onTap;

  const _ChoiceTile({
    required this.choice,
    required this.isSelected,
    required this.isMultiple,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? primaryColor : Colors.black12,
              width: isSelected ? 2.w : 1.w,
            ),
            borderRadius: BorderRadius.circular(12.r),
            color: isSelected ? primaryColor.withValues(alpha: 0.08) : Theme.of(context).cardColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                isMultiple
                    ? (isSelected ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded)
                    : (isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded),
                size: 22.r,
                color: isSelected ? primaryColor : Colors.grey,
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  (choice.body ?? '').replaceAll(r'$', '\n'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                ),
              ),
              if (choice.figure != null && choice.figure!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.network(
                      choice.figure!,
                      width: 48.w,
                      height: 48.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Navigation bar providing "Previous", "Next", and "Submit" with double-submit guard
class _NavigationButtonsRow extends StatelessWidget {
  final QuizInProgress state;

  const _NavigationButtonsRow({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // "السابق" (Previous) button
        if (!state.isFirstQuestion)
          Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: state.isSubmitting
                  ? null
                  : () {
                      context.read<QuizCubit>().previousQuestion();
                    },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text('السابق'),
            ),
          ),
        if (!state.isFirstQuestion) SizedBox(width: 12.w),

        // "التالى" (Next) or "انتهاء" (Submit) button
        Expanded(
          flex: 2,
          child: CustomElevatedButton(
            text: state.isLastQuestion ? 'انتهاء وتأكيد الإجابات' : 'التالى',
            onPressed: state.isSubmitting
                ? () {} // Disabled while submitting
                : () {
                    if (state.isLastQuestion) {
                      context.read<QuizCubit>().submitQuiz();
                    } else {
                      context.read<QuizCubit>().nextQuestion();
                    }
                  },
          ),
        ),
      ],
    );
  }
}
