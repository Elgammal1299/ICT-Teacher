import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String username;

  final String email;

  @JsonKey(name: "first_name")
  final String firstName;

  @JsonKey(name: "middle_name")
  final String middleName;

  @JsonKey(name: "last_name")
  final String lastName;

  final String phone;

  @JsonKey(name: "parent_phone")
  final String parentPhone;

  final String grade;

  final String region;

  RegisterResponse({
    required this.username,
    required this.email,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phone,
    required this.parentPhone,
    required this.grade,
    required this.region,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
