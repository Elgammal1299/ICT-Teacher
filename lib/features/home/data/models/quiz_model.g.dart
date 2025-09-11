// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
  id: json['id'] as String?,
  title: json['title'] as String?,
  questions: (json['questions'] as List<dynamic>?)
      ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'questions': instance.questions?.map((e) => e.toJson()).toList(),
};

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['id'] as String?,
      body: json['body'] as String?,
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'choices': instance.choices?.map((e) => e.toJson()).toList(),
    };

ChoiceModel _$ChoiceModelFromJson(Map<String, dynamic> json) =>
    ChoiceModel(id: json['id'] as String?, body: json['body'] as String?);

Map<String, dynamic> _$ChoiceModelToJson(ChoiceModel instance) =>
    <String, dynamic>{'id': instance.id, 'body': instance.body};
