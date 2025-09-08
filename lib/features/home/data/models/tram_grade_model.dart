import 'package:json_annotation/json_annotation.dart';

part 'tram_grade_model.g.dart';

@JsonSerializable()
class TramGradeModel {
  final String id;
  final String name;
  final List<TermModel> terms;

  TramGradeModel({
    required this.id,
    required this.name,
    required this.terms,
  });

  factory TramGradeModel.fromJson(Map<String, dynamic> json) =>
      _$TramGradeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TramGradeModelToJson(this);
}

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

  TermModel({
    required this.id,
    required this.name,
    required this.isActive,
    this.lessonsUrl,
    this.revisionsUrl,
    this.weeklyAssessmentsUrl,
    this.monthlyExamsUrl,
  });

  factory TermModel.fromJson(Map<String, dynamic> json) =>
      _$TermModelFromJson(json);

  Map<String, dynamic> toJson() => _$TermModelToJson(this);
}
