import 'package:json_annotation/json_annotation.dart';

part 'accounts_id_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountsIdModel {
  final String id;
  final String username;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String phone;

  @JsonKey(name: 'parent_phone')
  final String parentPhone;

  final String grade;
  final String region;

  @JsonKey(name: 'is_active')
  final bool isActive;

  final List<ActivityModel> lessons;
  final List<ActivityModel> revisions;

  @JsonKey(name: 'weekly_assessments')
  final List<ActivityModel> weeklyAssessments;

  @JsonKey(name: 'monthly_exams')
  final List<ActivityModel> monthlyExams;

  AccountsIdModel({
    required this.id,
    required this.username,
    required this.fullName,
    required this.phone,
    required this.parentPhone,
    required this.grade,
    required this.region,
    required this.isActive,
    required this.lessons,
    required this.revisions,
    required this.weeklyAssessments,
    required this.monthlyExams,
  });

  factory AccountsIdModel.fromJson(Map<String, dynamic> json) =>
      _$AccountsIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountsIdModelToJson(this);
}

@JsonSerializable()
class ActivityModel {
  final String id;
  final String title;
  final bool visited;
  final int? score;
  final bool? quiz; 

  ActivityModel({
    required this.id,
    required this.title,
    required this.visited,
    this.score,
    this.quiz,
  });
    factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
