// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  fullName: json['full_name'] as String,
  role: json['role'] as String,
  gradeId: json['grade_id'] as String,
  gradeName: json['grade_name'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'full_name': instance.fullName,
  'role': instance.role,
  'grade_id': instance.gradeId,
  'grade_name': instance.gradeName,
};
