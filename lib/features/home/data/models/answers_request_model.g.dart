// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerItem _$AnswerItemFromJson(Map<String, dynamic> json) => AnswerItem(
  question: json['question'] as String,
  choices: (json['choices'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  text: json['text'] as String?,
);

Map<String, dynamic> _$AnswerItemToJson(AnswerItem instance) =>
    <String, dynamic>{
      'question': instance.question,
      'choices': ?instance.choices,
      'text': ?instance.text,
    };

AnswersRequestModel _$AnswersRequestModelFromJson(Map<String, dynamic> json) =>
    AnswersRequestModel(
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnswersRequestModelToJson(
  AnswersRequestModel instance,
) => <String, dynamic>{
  'answers': instance.answers.map((e) => e.toJson()).toList(),
};
