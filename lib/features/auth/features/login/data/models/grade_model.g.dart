// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradeModel _$GradeModelFromJson(Map<String, dynamic> json) => GradeModel(
  id: json['id'] as String,
  name: json['name'] as String,
  url: json['url'] as String?,
  level: (json['level'] as num?)?.toInt(),
  isActive: json['is_active'] as bool?,
);

Map<String, dynamic> _$GradeModelToJson(GradeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'level': instance.level,
      'is_active': instance.isActive,
    };
