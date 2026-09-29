// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessons_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonsModel _$LessonsModelFromJson(Map<String, dynamic> json) => LessonsModel(
  id: json['id'] as String,
  title: json['title'] as String,
  url: json['url'] as String,
  orderNumber: (json['order_number'] as num?)?.toInt(),
  intro: json['intro'] as String?,
  hasPdf: json['has_pdf'] as bool?,
  hasVideo: json['has_video'] as bool?,
  quiz: json['quiz'] as Map<String, dynamic>?,
  progress: json['progress'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$LessonsModelToJson(LessonsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'order_number': instance.orderNumber,
      'intro': instance.intro,
      'has_pdf': instance.hasPdf,
      'has_video': instance.hasVideo,
      'quiz': instance.quiz,
      'progress': instance.progress,
    };
