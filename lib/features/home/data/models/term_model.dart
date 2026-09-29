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
  factory TermModel.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_print
    print('DEBUG [TermModel.fromJson] parsing JSON payload: $json');
    try {
      return TermModel(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        isActive: json['is_active'] as bool? ?? true,
        lessonsUrl: json['lessons_url']?.toString(),
        revisionsUrl: json['revisions_url']?.toString(),
        gradeName: json['grade_name']?.toString() ??
            (json['grade'] is Map ? (json['grade'] as Map)['name']?.toString() : json['grade']?.toString()) ??
            '',
      );
    } catch (e, stack) {
      // ignore: avoid_print
      print('ERROR [TermModel.fromJson] Failed to parse JSON: $e\n$stack');
      rethrow;
    }
  }

  // لتحويل TermModel إلى JSON
  Map<String, dynamic> toJson() => _$TermModelToJson(this);
}
