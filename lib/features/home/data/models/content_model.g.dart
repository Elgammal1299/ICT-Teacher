// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentModel _$ContentModelFromJson(Map<String, dynamic> json) => ContentModel(
  id: json['id'] as String,
  title: json['title'] as String,
  intro: json['intro'] as String?,
  pdf: json['pdf'] as String?,
  videoUrl: json['video_url'] as String?,
  quiz: json['quiz'] == null
      ? null
      : QuizModel.fromJson(json['quiz'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ContentModelToJson(ContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'intro': instance.intro,
      'pdf': instance.pdf,
      'video_url': instance.videoUrl,
      'quiz': instance.quiz?.toJson(),
    };

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
