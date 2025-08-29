import 'package:json_annotation/json_annotation.dart';

part 'grade_id.g.dart';

@JsonSerializable()
class GradeId {
  final String id;
  final String name;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'lessons_url')
  final String lessonsUrl;
  @JsonKey(name: 'revisions_url')
  final String revisionsUrl;
  @JsonKey(name: 'weekly_assessments_url')
  final String weeklyAssessmentsUrl;
  @JsonKey(name: 'monthly_exams_url')
  final String monthlyExamsUrl;

  GradeId({
    required this.id,
    required this.name,
    required this.isActive,
    required this.lessonsUrl,
    required this.revisionsUrl,
    required this.weeklyAssessmentsUrl,
    required this.monthlyExamsUrl,
  });

  factory GradeId.fromJson(Map<String, dynamic> json) =>
      _$GradeIdFromJson(json);

  Map<String, dynamic> toJson() => _$GradeIdToJson(this);
}
