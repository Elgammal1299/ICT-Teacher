import 'package:json_annotation/json_annotation.dart';

part 'grade_model.g.dart';

@JsonSerializable()
class GradeModel {
  final String id;
  final String name;
  final String? url;
  final int? level;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  GradeModel({
    required this.id,
    required this.name,
    this.url,
    this.level,
    this.isActive,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) =>
      _$GradeModelFromJson(json);

  Map<String, dynamic> toJson() => _$GradeModelToJson(this);
}
