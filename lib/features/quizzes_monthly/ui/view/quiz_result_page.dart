import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/utils/responsive_utils.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';

class QuizResultPage extends StatelessWidget {
  final AnswersQuestionsModel result;

  const QuizResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final totalQuestions = result.questions.length;
    final percentage = ((result.score / totalQuestions) * 100).toStringAsFixed(
      1,
    );
    final correctAnswers = result.questions
        .where((q) => q.answeredCorrectly)
        .length;
    final wrongAnswers = totalQuestions - correctAnswers;

    return Scaffold(
      appBar: AppBar(title: Text("نتيجة الاختبار")),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: RS.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modern Score Header Card with Gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                // gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: AppColors.shadowMedium,
                //     blurRadius: 16.r,
                //     offset: Offset(0, 8.h),
                //   ),
                // ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                children: [
                  // Celebratory Icon (changes based on score)
                  // Icon(
                  //   _getCelebrationIcon(double.parse(percentage)),
                  //   size: 64.r,
                  //   color: Colors.white,
                  // ),
                  // RS.vSpaceS,

                  // Score Display

                  // RS.vSpaceXS,

                  // Stats Row with Modern Cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ModernStatCard(
                          icon: Icons.check_circle_rounded,
                          value: "$correctAnswers",
                          label: "إجابة صحيحة",
                          color: AppColors.success,
                        ),
                      ),
                      SizedBox(width: RS.spaceM),
                      Expanded(
                        child: ModernStatCard(
                          icon: Icons.cancel_rounded,
                          value: "$wrongAnswers",
                          label: "إجابة خاطئة",
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                  RS.vSpaceS,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ModernStatCard(
                          icon: Icons.question_mark_rounded,
                          value: "$totalQuestions",
                          label: "إجمالي الأسئلة",
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: RS.spaceM),
                      Expanded(
                        child: ModernStatCard(
                          icon: Icons.percent_rounded,
                          value: "$percentage%",
                          label: "النسبة المئوية",
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // RS.vSpaceL,

            // Questions List Header with modern design
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: RS.spaceM,
                vertical: RS.spaceS,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.assignment_rounded,
                      color: AppColors.backgroundSecondary,
                      size: RS.iconM,
                    ),
                  ),
                  SizedBox(width: RS.spaceS),
                  Text(
                    "تفاصيل الإجابات",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "$totalQuestions سؤال",
                      style: TextStyle(
                        fontSize: RS.textS,
                        color: AppColors.backgroundSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Questions List (non-scrollable, embedded)
            ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: RS.spaceM,
                vertical: RS.spaceS,
              ),
              itemCount: result.questions.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final question = result.questions[index];
                return _QuestionResultCard(
                  question: question,
                  questionNumber: index + 1,
                );
              },
            ),

            RS.vSpaceM,

            // Bottom Button - Modern Design
            Padding(
              padding: EdgeInsets.symmetric(horizontal: RS.spaceM),
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16.r),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: AppColors.primarySurface,
                  //     blurRadius: 12.r,
                  //     offset: Offset(0, 6.h),
                  //   ),
                  // ],
                ),
                child: CustomElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'العودة للصفحة الرئيسية',
                  icon: Icon(
                    Icons.home_rounded,
                    size: RS.iconM,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modern stat card widget
}

class ModernStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const ModernStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _QuestionResultCard extends StatelessWidget {
  final Question question;
  final int questionNumber;

  const _QuestionResultCard({
    required this.question,
    required this.questionNumber,
  });

  @override
  Widget build(BuildContext context) {
    final isCorrect = question.answeredCorrectly;

    return Container(
      margin: EdgeInsets.only(bottom: RS.spaceM),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isCorrect ? AppColors.success : AppColors.quizIncorrectBorder,
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: isCorrect
                ? AppColors.secondarySuccess
                : AppColors.quizIncorrectBorder,
            blurRadius: 2.r,
            offset: Offset(0, 1.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(RS.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Header - Modern Design
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Number Badge
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    gradient: isCorrect
                        ? AppColors.successGradient
                        : AppColors.errorGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (isCorrect ? AppColors.success : AppColors.error)
                            .withValues(alpha: 0.3),
                        blurRadius: 8.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "$questionNumber",
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                  ),
                ),
                SizedBox(width: RS.spaceS),

                // Question Text
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      (question.body).replaceAll(r'$', '\n'),
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                  ),
                ),
                SizedBox(width: RS.spaceS),

                // Status Icon
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: isCorrect ? AppColors.successBg : AppColors.errorBg,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    isCorrect
                        ? Icons.check_circle_rounded
                        : Icons.cancel_rounded,
                    color: isCorrect ? AppColors.success : AppColors.error,
                    size: RS.iconM,
                  ),
                ),
              ],
            ),

            SizedBox(height: RS.spaceM),

            // Choices Section
            ...question.choices.map((choice) {
              final isCorrectAnswer = choice.isCorrect;
              final isStudentAnswer = choice.isAnswered;

              return _buildChoiceItem(
                context,
                choice.body,
                isCorrectAnswer: isCorrectAnswer,
                isStudentAnswer: isStudentAnswer,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceItem(
  BuildContext context,
  String text, {
  required bool isCorrectAnswer,
  required bool isStudentAnswer,
}) {
  Color borderColor;
  Color textColor;
  Widget? leadingIcon;
  Widget? trailingWidget;

  if (isCorrectAnswer && isStudentAnswer) {
    borderColor = AppColors.success;
    textColor = AppColors.successDark;

    leadingIcon = Icon(
      Icons.check_circle_rounded,
      color: AppColors.success,
      size: RS.iconM,
    );

    trailingWidget = _buildModernTag(
      "إجابتك ✓",
      AppColors.success,
    );
  } else if (isCorrectAnswer && !isStudentAnswer) {
    borderColor = AppColors.success;
    textColor = AppColors.successDark;

    leadingIcon = Icon(
      Icons.check_circle_rounded,
      color: AppColors.success,
      size: RS.iconM,
    );

    trailingWidget = _buildModernTag(
      "الإجابة الصحيحة",
      AppColors.success,
    );
  } else if (!isCorrectAnswer && isStudentAnswer) {
    borderColor = AppColors.quizIncorrectBorder;
    textColor = AppColors.errorDark;

    leadingIcon = Icon(
      Icons.cancel_rounded,
      color: AppColors.error,
      size: RS.iconM,
    );

    trailingWidget = _buildModernTag(
      "إجابتك ✗",
      AppColors.error,
    );
  } else {
    borderColor = AppColors.quizNeutralBorder;
    textColor = Theme.of(context).canvasColor;

    leadingIcon = Icon(
      Icons.radio_button_unchecked_rounded,
      color: AppColors.borderDark,
      size: RS.iconM,
    );
  }

  return Container(
    margin: EdgeInsets.only(bottom: RS.spaceS),
    padding: EdgeInsets.all(14.r),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      border: Border.all(
        color: borderColor,
        width: 2.w,
      ),
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        if (isStudentAnswer || isCorrectAnswer)
          BoxShadow(
            color: borderColor.withValues(alpha: 0.2),
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: leadingIcon,
        ),

        SizedBox(width: RS.spaceS),

        Expanded(
          child: Text(
            text.replaceAll(r'$', '\n'),
            style: TextStyle(
              fontSize: RS.textM,
              fontWeight: FontWeight.w500,
              color: textColor,
              height: 1.5,
            ),
          ),
        ),

        if (trailingWidget != null) ...[
          SizedBox(width: RS.spaceS),
          trailingWidget,
        ],
      ],
    ),
  );
}

  Widget _buildModernTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
