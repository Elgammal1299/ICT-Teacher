// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterBody _$RegisterBodyFromJson(Map<String, dynamic> json) => RegisterBody(
  username: json['username'] as String,
  email: json['email'] as String,
  password1: json['password1'] as String,
  password2: json['password2'] as String,
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String,
  lastName: json['last_name'] as String,
  phone: json['phone'] as String,
  parentPhone: json['parent_phone'] as String,
  grade: json['grade'] as String,
  region: json['region'] as String,
);

Map<String, dynamic> _$RegisterBodyToJson(RegisterBody instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password1': instance.password1,
      'password2': instance.password2,
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'parent_phone': instance.parentPhone,
      'grade': instance.grade,
      'region': instance.region,
    };
