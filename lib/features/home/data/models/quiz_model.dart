import 'package:json_annotation/json_annotation.dart';

part 'quiz_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizModel {
  final String? id;
  final String? title;
  final List<QuestionModel>? questions;

  QuizModel({this.id, this.title, this.questions});

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuestionModel {
  final String? id;
  final String? body;
  final List<ChoiceModel>? choices;

  QuestionModel({this.id, this.body, this.choices});

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable()
class ChoiceModel {
  final String? id;
  final String? body;

  ChoiceModel({this.id, this.body});

  factory ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceModelToJson(this);
}
