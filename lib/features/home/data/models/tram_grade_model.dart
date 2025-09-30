import 'package:icd_teacher/features/home/data/models/term_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tram_grade_model.g.dart';

@JsonSerializable()
class TramGradeModel {
  final String id;
  final String name;
  final List<TermModel> terms;

  TramGradeModel({
    required this.id,
    required this.name,
    required this.terms,
  });

  factory TramGradeModel.fromJson(Map<String, dynamic> json) =>
      _$TramGradeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TramGradeModelToJson(this);
}

