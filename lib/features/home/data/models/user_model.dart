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
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_print
    print('DEBUG [UserModel.fromJson] parsing JSON payload: $json');
    try {
      String parsedGradeId = '';
      String parsedGradeName = '';
      if (json['grade'] is Map) {
        final gradeMap = json['grade'] as Map<String, dynamic>;
        parsedGradeId = gradeMap['id']?.toString() ?? '';
        parsedGradeName = gradeMap['name']?.toString() ?? '';
      } else {
        parsedGradeId = json['grade_id']?.toString() ?? json['gradeId']?.toString() ?? json['grade']?.toString() ?? '';
        parsedGradeName = json['grade_name']?.toString() ?? json['gradeName']?.toString() ?? '';
      }

      return UserModel(
        id: json['id']?.toString() ?? '',
        username: json['username']?.toString() ?? '',
        fullName: json['full_name']?.toString() ?? json['fullName']?.toString() ?? '',
        role: json['role']?.toString() ?? '',
        gradeId: parsedGradeId,
        gradeName: parsedGradeName,
      );
    } catch (e, stack) {
      // ignore: avoid_print
      print('ERROR [UserModel.fromJson] Failed to parse JSON: $e\n$stack');
      rethrow;
    }
  }

  /// toJson
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
