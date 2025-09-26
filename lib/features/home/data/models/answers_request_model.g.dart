// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswersRequestModel _$AnswersRequestModelFromJson(Map<String, dynamic> json) =>
    AnswersRequestModel(
      answers: (json['answers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AnswersRequestModelToJson(
  AnswersRequestModel instance,
) => <String, dynamic>{'answers': instance.answers};
