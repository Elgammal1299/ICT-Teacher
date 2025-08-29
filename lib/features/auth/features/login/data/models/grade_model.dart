import 'package:json_annotation/json_annotation.dart';

part 'grade_model.g.dart';

@JsonSerializable()
class GradeModel {
  final String id;
  final String name;
  final String url;

  GradeModel({
    required this.id,
    required this.name,
    required this.url,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) =>
      _$GradeModelFromJson(json);

  Map<String, dynamic> toJson() => _$GradeModelToJson(this);
}
