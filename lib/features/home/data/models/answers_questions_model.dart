import 'package:json_annotation/json_annotation.dart';

part 'answers_questions_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AnswersQuestionsModel {
  final int score;
  final List<Question> questions;

  AnswersQuestionsModel({required this.score, required this.questions});

  factory AnswersQuestionsModel.fromJson(Map<String, dynamic> json) =>
      _$AnswersQuestionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersQuestionsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Question {
  final String id;
  final String body;

  @JsonKey(name: 'answered_correctly')
  final bool answeredCorrectly;

  final List<Choice> choices;

  Question({
    required this.id,
    required this.body,
    required this.answeredCorrectly,
    required this.choices,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Choice {
  final String id;
  final String body;

  @JsonKey(name: 'is_correct')
  final bool isCorrect;

  @JsonKey(name: 'is_answered')
  final bool isAnswered;

  Choice({
    required this.id,
    required this.body,
    required this.isCorrect,
    required this.isAnswered,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}
