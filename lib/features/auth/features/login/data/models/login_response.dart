import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String refresh;
  final String access;

  LoginResponse({
    required this.refresh,
    required this.access,
  });

  /// fromJson
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
