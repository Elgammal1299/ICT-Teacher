// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsModel _$AccountsModelFromJson(Map<String, dynamic> json) =>
    AccountsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      registeredStudents: (json['registered_students'] as num).toInt(),
      students: (json['students'] as List<dynamic>)
          .map((e) => StudentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountsModelToJson(AccountsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'registered_students': instance.registeredStudents,
      'students': instance.students.map((e) => e.toJson()).toList(),
    };

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
  id: json['id'] as String,
  username: json['username'] as String,
  fullName: json['full_name'] as String,
  isActive: json['is_active'] as bool,
  url: json['url'] as String,
);

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'full_name': instance.fullName,
      'is_active': instance.isActive,
      'url': instance.url,
    };
