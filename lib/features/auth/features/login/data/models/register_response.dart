import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String? id;
  final String username;
  final String email;

  @JsonKey(name: "full_name")
  final String? fullName;

  @JsonKey(name: "first_name")
  final String? firstName;

  @JsonKey(name: "middle_name")
  final String? middleName;

  @JsonKey(name: "last_name")
  final String? lastName;

  final String? phone;

  @JsonKey(name: "parent_phone")
  final String? parentPhone;

  final String? grade;

  final String? region;

  final String? role;

  RegisterResponse({
    this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.phone,
    this.parentPhone,
    this.grade,
    this.region,
    this.role,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    String gradeVal = '';
    if (json['grade'] is Map) {
      gradeVal = json['grade']['name']?.toString() ?? json['grade']['id']?.toString() ?? '';
    } else if (json['grade'] != null) {
      gradeVal = json['grade'].toString();
    }

    String regionVal = '';
    if (json['region'] is Map) {
      regionVal = json['region']['name']?.toString() ?? json['region']['id']?.toString() ?? '';
    } else if (json['region'] != null) {
      regionVal = json['region'].toString();
    }

    return RegisterResponse(
      id: json['id']?.toString(),
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      fullName: json['full_name']?.toString(),
      firstName: json['first_name']?.toString(),
      middleName: json['middle_name']?.toString(),
      lastName: json['last_name']?.toString(),
      phone: json['phone']?.toString(),
      parentPhone: json['parent_phone']?.toString(),
      grade: gradeVal,
      region: regionVal,
      role: json['role']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
