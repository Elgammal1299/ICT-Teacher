import 'package:json_annotation/json_annotation.dart';

part 'answers_request_model.g.dart';

@JsonSerializable()
class AnswersRequestModel {
  final List<String> answers;

  AnswersRequestModel({required this.answers});

  factory AnswersRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AnswersRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersRequestModelToJson(this);
}
