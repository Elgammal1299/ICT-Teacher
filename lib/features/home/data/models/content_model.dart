import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
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
