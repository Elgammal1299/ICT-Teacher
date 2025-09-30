// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermModel _$TermModelFromJson(Map<String, dynamic> json) => TermModel(
  id: json['id'] as String,
  name: json['name'] as String,
  isActive: json['is_active'] as bool,
  lessonsUrl: json['lessons_url'] as String?,
  revisionsUrl: json['revisions_url'] as String?,
  weeklyAssessmentsUrl: json['weekly_assessments_url'] as String?,
  monthlyExamsUrl: json['monthly_exams_url'] as String?,
  gradeName: json['grade_name'] as String,
);

Map<String, dynamic> _$TermModelToJson(TermModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'is_active': instance.isActive,
  'lessons_url': instance.lessonsUrl,
  'revisions_url': instance.revisionsUrl,
  'weekly_assessments_url': instance.weeklyAssessmentsUrl,
  'monthly_exams_url': instance.monthlyExamsUrl,
  'grade_name': instance.gradeName,
};
