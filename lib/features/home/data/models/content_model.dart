import 'package:json_annotation/json_annotation.dart';

part 'content_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ContentModel {
  final String id;
  final String title;
  final String? intro;
  final String? pdf;
  @JsonKey(name: "video_url")
  final String? videoUrl;
  final QuizModel? quiz;

  ContentModel({
    required this.id,
    required this.title,
    this.intro,
    this.pdf,
    this.videoUrl,
    this.quiz,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) =>
      _$ContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuizModel {
  final String id;
  final String title;
  final List<QuestionModel> questions;

  QuizModel({
    required this.id,
    required this.title,
    required this.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuestionModel {
  final String id;
  final String body;
  final List<ChoiceModel> choices;

  QuestionModel({
    required this.id,
    required this.body,
    required this.choices,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable()
class ChoiceModel {
  final String id;
  final String body;

  ChoiceModel({
    required this.id,
    required this.body,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceModelToJson(this);
}
