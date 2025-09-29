import 'package:json_annotation/json_annotation.dart';

part 'accounts_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountsModel {
  final String id;
  final String name;

  @JsonKey(name: 'registered_students')
  final int registeredStudents;

  final List<StudentModel> students;

  AccountsModel({
    required this.id,
    required this.name,
    required this.registeredStudents,
    required this.students,
  });

  factory AccountsModel.fromJson(Map<String, dynamic> json) =>
      _$AccountsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountsModelToJson(this);
}

@JsonSerializable()
class StudentModel {
  final String id;
  final String username;

  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'is_active')
  final bool isActive;

  final String url;

  StudentModel({
    required this.id,
    required this.username,
    required this.fullName,
    required this.isActive,
    required this.url,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
