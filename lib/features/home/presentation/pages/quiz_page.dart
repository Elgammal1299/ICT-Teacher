import 'package:flutter/material.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view/quiz_questions_page.dart';

/// Legacy QuizPage entry point kept for backward compatibility.
/// All quiz logic has been migrated to [QuizQuestionsPage] powered by [QuizCubit]
/// conforming to the new Swagger API contract.
@Deprecated('Use QuizQuestionsPage with QuizCubit instead.')
class QuizPage extends StatelessWidget {
  final QuizModel quiz;

  const QuizPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return QuizQuestionsPage(
      quizId: quiz.id ?? '',
      quizTitle: quiz.title ?? 'الاختبار',
    );
  }
}
