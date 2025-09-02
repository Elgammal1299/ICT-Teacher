import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String username;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String role;

  @JsonKey(name: 'grade_id')
  final String gradeId;

  @JsonKey(name: 'grade_name')
  final String gradeName;

  UserModel({
    required this.id,
    required this.username,
    required this.fullName,
    required this.role,
    required this.gradeId,
    required this.gradeName,
  });

  /// fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
