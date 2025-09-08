import 'package:json_annotation/json_annotation.dart';

part 'lessons_model.g.dart';

@JsonSerializable()
class LessonsModel {
  final String id;
  final String title;
  final String url;

  LessonsModel({
    required this.id,
    required this.title,
    required this.url,
  });

  factory LessonsModel.fromJson(Map<String, dynamic> json) =>
      _$LessonsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonsModelToJson(this);

  /// علشان نعمل من ليست كاملة
  static List<LessonsModel> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((e) => LessonsModel.fromJson(e)).toList();
  }
}
