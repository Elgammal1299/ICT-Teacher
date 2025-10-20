import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "نتيجة الاختبار",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score Header Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  // Score Circle
                  Container(
                    decoration: BoxDecoration(),
                    child: Row(
                      children: [
                        Text(
                          "النسبة المئوية :",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "$percentage%",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _getScoreColor(double.parse(percentage)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(
                        Icons.check_circle,
                        "$correctAnswers",
                        "إجابة صحيحة",
                        Colors.green,
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildStatItem(
                        Icons.cancel,
                        "$wrongAnswers",
                        "إجابة خاطئة",
                        Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 16),

            // Questions List Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.list_alt, color: AppColors.primary, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    "تفاصيل الإجابات",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Questions List (non-scrollable, embedded)
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

            // Bottom Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.home_rounded),
                  label: const Text(
                    "العودة للصفحة الرئيسية",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.orange;
    return Colors.red;
  }

  Widget _buildStatItem(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Icon(icon, color: Colors.white, size: 28),
          ],
        ),

        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
        ),
      ],
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

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isCorrect
              ? Colors.green.withOpacity(0.3)
              : Colors.red.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Header
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isCorrect ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "$questionNumber",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question.body,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? Colors.green : Colors.red,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Choices
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

    if (isCorrectAnswer && isStudentAnswer) {
      backgroundColor = Colors.green.withOpacity(0.1);
      borderColor = Colors.green;
      textColor = Colors.green.shade900;
      leadingIcon = const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 20,
      );
      trailingWidget = _buildTag("إجابتك ✓", Colors.green);
    } else if (isCorrectAnswer && !isStudentAnswer) {
      backgroundColor = Colors.green.withOpacity(0.1);
      borderColor = Colors.green;
      textColor = Colors.green.shade900;
      leadingIcon = const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 20,
      );
      trailingWidget = _buildTag("الإجابة الصحيحة", Colors.green);
    } else if (!isCorrectAnswer && isStudentAnswer) {
      backgroundColor = Colors.red.withOpacity(0.1);
      borderColor = Colors.red;
      textColor = Colors.red.shade900;
      leadingIcon = const Icon(Icons.cancel, color: Colors.red, size: 20);
      trailingWidget = _buildTag("إجابتك ✗", Colors.red);
    } else {
      backgroundColor = Colors.grey.withOpacity(0.05);
      borderColor = Colors.grey.shade300;
      textColor = Colors.grey.shade700;
      leadingIcon = Icon(
        Icons.circle_outlined,
        color: Colors.grey.shade400,
        size: 20,
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          leadingIcon,
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          if (trailingWidget != null) ...[
            const SizedBox(width: 8),
            trailingWidget,
          ],
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
