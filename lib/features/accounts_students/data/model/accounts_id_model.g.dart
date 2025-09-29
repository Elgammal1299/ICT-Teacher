// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsIdModel _$AccountsIdModelFromJson(Map<String, dynamic> json) =>
    AccountsIdModel(
      id: json['id'] as String,
      username: json['username'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      parentPhone: json['parent_phone'] as String,
      grade: json['grade'] as String,
      region: json['region'] as String,
      isActive: json['is_active'] as bool,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      revisions: (json['revisions'] as List<dynamic>)
          .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      weeklyAssessments: (json['weekly_assessments'] as List<dynamic>)
          .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      monthlyExams: (json['monthly_exams'] as List<dynamic>)
          .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountsIdModelToJson(AccountsIdModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'full_name': instance.fullName,
      'phone': instance.phone,
      'parent_phone': instance.parentPhone,
      'grade': instance.grade,
      'region': instance.region,
      'is_active': instance.isActive,
      'lessons': instance.lessons.map((e) => e.toJson()).toList(),
      'revisions': instance.revisions.map((e) => e.toJson()).toList(),
      'weekly_assessments': instance.weeklyAssessments
          .map((e) => e.toJson())
          .toList(),
      'monthly_exams': instance.monthlyExams.map((e) => e.toJson()).toList(),
    };

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      id: json['id'] as String,
      title: json['title'] as String,
      visited: json['visited'] as bool,
      score: (json['score'] as num?)?.toInt(),
      quiz: json['quiz'] as bool?,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'visited': instance.visited,
      'score': instance.score,
      'quiz': instance.quiz,
    };
