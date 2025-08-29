import 'package:json_annotation/json_annotation.dart';

part 'register_body.g.dart';

@JsonSerializable()
class RegisterBody {
  final String username;
  final String email;
  final String password1;
  final String password2;
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

  RegisterBody({
    required this.username,
    required this.email,
    required this.password1,
    required this.password2,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phone,
    required this.parentPhone,
    required this.grade,
    required this.region,
  });

  /// من JSON → Object
  factory RegisterBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterBodyFromJson(json);

  /// من Object → JSON
  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);
}
