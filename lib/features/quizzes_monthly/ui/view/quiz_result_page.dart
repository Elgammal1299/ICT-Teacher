import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/utils/responsive_utils.dart';
import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';

class QuizResultPage extends StatelessWidget {
  final AnswersQuestionsModel result;

  const QuizResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final totalQuestions = result.questions.length;
    final percentage = ((result.score / totalQuestions) * 100).toStringAsFixed(1);
    final correctAnswers = result.questions.where((q) => q.answeredCorrectly).length;
    final wrongAnswers = totalQuestions - correctAnswers;

    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          "نتيجة الاختبار",
          style: TextStyle(
            fontFamily: 'Amiri',
            
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: RS.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modern Score Header Card with Gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowMedium,
                    blurRadius: 16.r,
                    offset: Offset(0, 8.h),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: RS.spaceM, vertical: RS.spaceXL),
              child: Column(
                children: [
                  // Celebratory Icon (changes based on score)
                  Icon(
                    _getCelebrationIcon(double.parse(percentage)),
                    size: 64.r,
                    color: Colors.white,
                  ),
                  RS.vSpaceS,

                  // Score Display
                  Text(
                    "النسبة المئوية",
                    style: TextStyle(
                      fontSize: RS.textL,
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RS.vSpaceXS,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 2.w,
                      ),
                    ),
                    child: Text(
                      "$percentage%",
                      style: TextStyle(
                        fontSize: 42.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  RS.vSpaceL,

                  // Stats Row with Modern Cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildModernStatCard(
                          Icons.check_circle_rounded,
                          "$correctAnswers",
                          "إجابة صحيحة",
                          AppColors.success,
                        ),
                      ),
                      SizedBox(width: RS.spaceM),
                      Expanded(
                        child: _buildModernStatCard(
                          Icons.cancel_rounded,
                          "$wrongAnswers",
                          "إجابة خاطئة",
                          AppColors.error,
                        ),
                      ),
                    ],
                  ),
                  RS.vSpaceS,

                  // Total questions indicator
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      "إجمالي الأسئلة: $totalQuestions",
                      style: TextStyle(
                        fontSize: RS.textM,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            RS.vSpaceL,

            // Questions List Header with modern design
            Padding(
              padding: EdgeInsets.symmetric(horizontal: RS.spaceM, vertical: RS.spaceS),
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
                      color: AppColors.primary,
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
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "$totalQuestions سؤال",
                      style: TextStyle(
                        fontSize: RS.textS,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Questions List (non-scrollable, embedded)
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: RS.spaceM, vertical: RS.spaceS),
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
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12.r,
                      offset: Offset(0, 6.h),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.home_rounded, size: RS.iconM),
                  label: Text(
                    "العودة للصفحة الرئيسية",
                    style: TextStyle(
                      fontSize: RS.textL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    minimumSize: Size(double.infinity, 56.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get celebration icon based on score
  IconData _getCelebrationIcon(double percentage) {
    if (percentage >= 90) return Icons.emoji_events_rounded; // Trophy for excellent
    if (percentage >= 75) return Icons.star_rounded; // Star for very good
    if (percentage >= 60) return Icons.thumb_up_rounded; // Thumbs up for good
    return Icons.school_rounded; // School icon for needs improvement
  }

  // Modern stat card widget
  Widget _buildModernStatCard(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32.r),
          SizedBox(height: 8.h),
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
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
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
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isCorrect ? AppColors.quizCorrectBorder : AppColors.quizIncorrectBorder,
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: isCorrect
                ? AppColors.success.withValues(alpha: 0.1)
                : AppColors.error.withValues(alpha: 0.1),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
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
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: RS.textL,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: RS.spaceS),

                // Question Text
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      question.body,
                      style: TextStyle(
                        fontSize: RS.textM,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: RS.spaceS),

                // Status Icon
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? AppColors.successBg
                        : AppColors.errorBg,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
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
    String text, {
    required bool isCorrectAnswer,
    required bool isStudentAnswer,
  }) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    Widget? leadingIcon;
    Widget? trailingWidget;

    // Modern color scheme based on answer state
    if (isCorrectAnswer && isStudentAnswer) {
      // Student's answer is correct - Green with celebration
      backgroundColor = AppColors.quizCorrectBg;
      borderColor = AppColors.quizCorrectBorder;
      textColor = AppColors.successDark;
      leadingIcon = Icon(
        Icons.check_circle_rounded,
        color: AppColors.success,
        size: RS.iconM,
      );
      trailingWidget = _buildModernTag("إجابتك ✓", AppColors.success);
    } else if (isCorrectAnswer && !isStudentAnswer) {
      // Correct answer not selected by student - Show what should have been selected
      backgroundColor = AppColors.quizCorrectBg;
      borderColor = AppColors.quizCorrectBorder;
      textColor = AppColors.successDark;
      leadingIcon = Icon(
        Icons.check_circle_rounded,
        color: AppColors.success,
        size: RS.iconM,
      );
      trailingWidget = _buildModernTag("الإجابة الصحيحة", AppColors.success);
    } else if (!isCorrectAnswer && isStudentAnswer) {
      // Student's incorrect answer - Red highlighting
      backgroundColor = AppColors.quizIncorrectBg;
      borderColor = AppColors.quizIncorrectBorder;
      textColor = AppColors.errorDark;
      leadingIcon = Icon(
        Icons.cancel_rounded,
        color: AppColors.error,
        size: RS.iconM,
      );
      trailingWidget = _buildModernTag("إجابتك ✗", AppColors.error);
    } else {
      // Neutral/unselected options - Gray
      backgroundColor = AppColors.quizNeutral;
      borderColor = AppColors.quizNeutralBorder;
      textColor = AppColors.textSecondary;
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
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 2.w),
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
              text,
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
