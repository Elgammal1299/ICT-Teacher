// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_questions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswersQuestionsModel _$AnswersQuestionsModelFromJson(
  Map<String, dynamic> json,
) => AnswersQuestionsModel(
  score: (json['score'] as num).toInt(),
  questions: (json['questions'] as List<dynamic>)
      .map((e) => Question.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AnswersQuestionsModelToJson(
  AnswersQuestionsModel instance,
) => <String, dynamic>{
  'score': instance.score,
  'questions': instance.questions.map((e) => e.toJson()).toList(),
};

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
  id: json['id'] as String,
  body: json['body'] as String,
  answeredCorrectly: json['answered_correctly'] as bool,
  choices: (json['choices'] as List<dynamic>)
      .map((e) => Choice.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
  'id': instance.id,
  'body': instance.body,
  'answered_correctly': instance.answeredCorrectly,
  'choices': instance.choices.map((e) => e.toJson()).toList(),
};

Choice _$ChoiceFromJson(Map<String, dynamic> json) => Choice(
  id: json['id'] as String,
  body: json['body'] as String,
  isCorrect: json['is_correct'] as bool,
  isAnswered: json['is_answered'] as bool,
);

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
  'id': instance.id,
  'body': instance.body,
  'is_correct': instance.isCorrect,
  'is_answered': instance.isAnswered,
};
