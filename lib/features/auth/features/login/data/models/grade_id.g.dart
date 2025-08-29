// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradeId _$GradeIdFromJson(Map<String, dynamic> json) => GradeId(
  id: json['id'] as String,
  name: json['name'] as String,
  isActive: json['is_active'] as bool,
  lessonsUrl: json['lessons_url'] as String,
  revisionsUrl: json['revisions_url'] as String,
  weeklyAssessmentsUrl: json['weekly_assessments_url'] as String,
  monthlyExamsUrl: json['monthly_exams_url'] as String,
);

Map<String, dynamic> _$GradeIdToJson(GradeId instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'is_active': instance.isActive,
  'lessons_url': instance.lessonsUrl,
  'revisions_url': instance.revisionsUrl,
  'weekly_assessments_url': instance.weeklyAssessmentsUrl,
  'monthly_exams_url': instance.monthlyExamsUrl,
};
