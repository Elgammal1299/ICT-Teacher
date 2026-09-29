// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
  id: json['id'] as String?,
  title: json['title'] as String?,
  quizType: json['quiz_type'] as String?,
  passScore: (json['pass_score'] as num?)?.toInt(),
  maxScore: (json['max_score'] as num?)?.toInt(),
  term: json['term'] as Map<String, dynamic>?,
  content: json['content'] as Map<String, dynamic>?,
  questions: (json['questions'] as List<dynamic>?)
      ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  submission: json['submission'] == null
      ? null
      : AnswersQuestionsModel.fromJson(
          json['submission'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'quiz_type': instance.quizType,
  'pass_score': instance.passScore,
  'max_score': instance.maxScore,
  'term': instance.term,
  'content': instance.content,
  'questions': instance.questions?.map((e) => e.toJson()).toList(),
  'submission': instance.submission?.toJson(),
};

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['id'] as String?,
      body: json['body'] as String?,
      questionType: json['question_type'] as String?,
      multiple: json['multiple'] as bool?,
      points: (json['points'] as num?)?.toInt(),
      figure: json['figure'] as String?,
      orderNumber: (json['order_number'] as num?)?.toInt(),
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'question_type': instance.questionType,
      'multiple': instance.multiple,
      'points': instance.points,
      'figure': instance.figure,
      'order_number': instance.orderNumber,
      'choices': instance.choices?.map((e) => e.toJson()).toList(),
    };

ChoiceModel _$ChoiceModelFromJson(Map<String, dynamic> json) => ChoiceModel(
  id: json['id'] as String?,
  body: json['body'] as String?,
  figure: json['figure'] as String?,
  orderNumber: (json['order_number'] as num?)?.toInt(),
);

Map<String, dynamic> _$ChoiceModelToJson(ChoiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'figure': instance.figure,
      'order_number': instance.orderNumber,
    };
