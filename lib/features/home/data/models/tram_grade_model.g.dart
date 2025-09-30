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
