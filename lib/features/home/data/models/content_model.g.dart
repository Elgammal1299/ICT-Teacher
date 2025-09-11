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
