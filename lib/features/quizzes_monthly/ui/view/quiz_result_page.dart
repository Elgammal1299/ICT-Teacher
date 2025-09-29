
import 'package:flutter/material.dart';
import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';

class QuizResultPage extends StatelessWidget {
  final AnswersQuestionsModel result;

  const QuizResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("نتيجة الاختبار")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "النتيجة: ${result.score} | عدد الاسئلة :${result.questions.length} ",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: result.questions.length,
                itemBuilder: (context, index) {
                  final q = result.questions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(q.body),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: q.choices.map((c) {
                          return Row(
                            children: [
                              Icon(
                                Icons.radio_button_checked,
                                color: c.isCorrect ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(c.body),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
