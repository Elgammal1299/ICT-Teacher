// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tram_grade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TramGradeModel _$TramGradeModelFromJson(Map<String, dynamic> json) =>
    TramGradeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      terms: (json['terms'] as List<dynamic>)
          .map((e) => TermModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TramGradeModelToJson(TramGradeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'terms': instance.terms,
    };

TermModel _$TermModelFromJson(Map<String, dynamic> json) => TermModel(
  id: json['id'] as String,
  name: json['name'] as String,
  isActive: json['is_active'] as bool,
  lessonsUrl: json['lessons_url'] as String?,
  revisionsUrl: json['revisions_url'] as String?,
  weeklyAssessmentsUrl: json['weekly_assessments_url'] as String?,
  monthlyExamsUrl: json['monthly_exams_url'] as String?,
);

Map<String, dynamic> _$TermModelToJson(TermModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'is_active': instance.isActive,
  'lessons_url': instance.lessonsUrl,
  'revisions_url': instance.revisionsUrl,
  'weekly_assessments_url': instance.weeklyAssessmentsUrl,
  'monthly_exams_url': instance.monthlyExamsUrl,
};
