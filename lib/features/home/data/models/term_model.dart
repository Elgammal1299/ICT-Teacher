import 'package:json_annotation/json_annotation.dart';

part 'term_model.g.dart';

@JsonSerializable()
class TermModel {
  final String id;
  final String name;

  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'lessons_url')
  final String? lessonsUrl;

  @JsonKey(name: 'revisions_url')
  final String? revisionsUrl;

  @JsonKey(name: 'weekly_assessments_url')
  final String? weeklyAssessmentsUrl;

  @JsonKey(name: 'monthly_exams_url')
  final String? monthlyExamsUrl;

  @JsonKey(name: 'grade_name')
  final String gradeName;

  TermModel({
    required this.id,
    required this.name,
    required this.isActive,
    this.lessonsUrl,
    this.revisionsUrl,
    this.weeklyAssessmentsUrl,
    this.monthlyExamsUrl,
    required this.gradeName,
  });

  // لتحويل JSON إلى TermModel
  factory TermModel.fromJson(Map<String, dynamic> json) =>
      _$TermModelFromJson(json);

  // لتحويل TermModel إلى JSON
  Map<String, dynamic> toJson() => _$TermModelToJson(this);
}
