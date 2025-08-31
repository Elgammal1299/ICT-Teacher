import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable()
class LoginBody {
  final String username;
  final String password;

  LoginBody({
    required this.username,
    required this.password,
  });

  /// fromJson
  factory LoginBody.fromJson(Map<String, dynamic> json) =>
      _$LoginBodyFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
}
