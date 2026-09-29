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
    final maxScore = (result.maxScore != null && result.maxScore! > 0)
        ? result.maxScore!
        : (totalQuestions > 0 ? totalQuestions : 1);
    final percentage = ((result.score / maxScore) * 100).toStringAsFixed(1);
    final correctAnswers = result.questions
        .where((q) => q.answeredCorrectly)
        .length;
    final wrongAnswers = totalQuestions - correctAnswers;
    final hasPendingEssays = result.hasPendingEssays ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text("نتيجة الاختبار")),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: RS.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modern Score Header Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: Column(
                children: [
                  // Pass/Fail status or Pending Banner
                  if (hasPendingEssays)
                    Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade700,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.hourglass_top_rounded, color: Colors.white, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            "إجاباتك المقالية قيد التصحيح بواسطة المعلم",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (result.isPassed != null)
                    Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: (result.isPassed == true) ? AppColors.success : AppColors.error,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        (result.isPassed == true) ? "مبروك! لقد اجتزت الاختبار بنجاح 🎉" : "لم تجتز الاختبار، حاول مرة أخرى 💡",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  // Score Display
                  Text(
                    "الدرجة: ${result.score} / $maxScore",
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Stats Row
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

            // Questions List Header
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
                  const Spacer(),
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

            // Questions List
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

            // Display essay feedback cards if essay answers exist
            if (result.essayAnswers != null && result.essayAnswers!.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: RS.spaceM, vertical: RS.spaceS),
                child: Text(
                  "تفاصيل الأسئلة المقالية",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: RS.spaceM),
                itemCount: result.essayAnswers!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final essay = result.essayAnswers![index];
                  return Container(
                    margin: EdgeInsets.only(bottom: RS.spaceM),
                    padding: EdgeInsets.all(RS.spaceM),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.amber.shade300, width: 1.5.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "السؤال: ${essay.body ?? ''}",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "إجابتك: ${essay.answerText ?? ''}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          essay.pointsAwarded == null
                              ? "الحالة: قيد التصحيح من قبل المعلم"
                              : "الدرجة المستحقة: ${essay.pointsAwarded} / ${essay.points ?? 0}",
                          style: TextStyle(
                            color: essay.pointsAwarded == null ? Colors.amber.shade900 : AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (essay.correctAnswer != null && essay.correctAnswer!.isNotEmpty) ...[
                          SizedBox(height: 6.h),
                          Text(
                            "الإجابة النموذجية: ${essay.correctAnswer!}",
                            style: TextStyle(
                              color: Colors.green.shade800,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ],

            RS.vSpaceM,

            // Return to Home button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: RS.spaceM),
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
          ],
        ),
      ),
    );
  }
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
      ),
      child: Padding(
        padding: EdgeInsets.all(RS.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    color: isCorrect ? AppColors.success : AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "$questionNumber",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: RS.spaceS),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      (question.body).replaceAll(r'$', '\n'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                SizedBox(width: RS.spaceS),
                Icon(
                  isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: isCorrect ? AppColors.success : AppColors.error,
                  size: RS.iconM,
                ),
              ],
            ),
            SizedBox(height: RS.spaceM),
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
      leadingIcon = Icon(Icons.check_circle_rounded, color: AppColors.success, size: RS.iconM);
      trailingWidget = _buildModernTag("إجابتك ✓", AppColors.success);
    } else if (isCorrectAnswer && !isStudentAnswer) {
      borderColor = AppColors.success;
      textColor = AppColors.successDark;
      leadingIcon = Icon(Icons.check_circle_rounded, color: AppColors.success, size: RS.iconM);
      trailingWidget = _buildModernTag("الإجابة الصحيحة", AppColors.success);
    } else if (!isCorrectAnswer && isStudentAnswer) {
      borderColor = AppColors.quizIncorrectBorder;
      textColor = AppColors.errorDark;
      leadingIcon = Icon(Icons.cancel_rounded, color: AppColors.error, size: RS.iconM);
      trailingWidget = _buildModernTag("إجابتك ✗", AppColors.error);
    } else {
      borderColor = AppColors.quizNeutralBorder;
      textColor = Theme.of(context).canvasColor;
      leadingIcon = Icon(Icons.radio_button_unchecked_rounded, color: AppColors.borderDark, size: RS.iconM);
    }

    return Container(
      margin: EdgeInsets.only(bottom: RS.spaceS),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: borderColor, width: 2.w),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 2.h), child: leadingIcon),
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
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
