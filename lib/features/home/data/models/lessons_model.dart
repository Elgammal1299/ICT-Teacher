import 'package:json_annotation/json_annotation.dart';

part 'lessons_model.g.dart';

@JsonSerializable()
class LessonsModel {
  final String id;
  final String title;
  final String url;

  @JsonKey(name: 'order_number')
  final int? orderNumber;

  final String? intro;

  @JsonKey(name: 'has_pdf')
  final bool? hasPdf;

  @JsonKey(name: 'has_video')
  final bool? hasVideo;

  final Map<String, dynamic>? quiz;
  final Map<String, dynamic>? progress;

  LessonsModel({
    required this.id,
    required this.title,
    required this.url,
    this.orderNumber,
    this.intro,
    this.hasPdf,
    this.hasVideo,
    this.quiz,
    this.progress,
  });

  factory LessonsModel.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_print
    print('DEBUG [LessonsModel.fromJson] parsing JSON payload: $json');
    try {
      return LessonsModel(
        id: json['id']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        url: json['url']?.toString() ?? json['pdf_url']?.toString() ?? json['pdf']?.toString() ?? '',
        orderNumber: json['order_number'] is int ? json['order_number'] as int : int.tryParse(json['order_number']?.toString() ?? ''),
        intro: json['intro']?.toString(),
        hasPdf: json['has_pdf'] as bool?,
        hasVideo: json['has_video'] as bool?,
        quiz: json['quiz'] is Map<String, dynamic> ? json['quiz'] as Map<String, dynamic> : null,
        progress: json['progress'] is Map<String, dynamic> ? json['progress'] as Map<String, dynamic> : null,
      );
    } catch (e, stack) {
      // ignore: avoid_print
      print('ERROR [LessonsModel.fromJson] Failed to parse JSON: $e\n$stack');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$LessonsModelToJson(this);

  /// علشان نعمل من ليست كاملة
  static List<LessonsModel> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((e) => LessonsModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
