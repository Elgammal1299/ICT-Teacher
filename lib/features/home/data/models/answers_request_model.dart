import 'package:json_annotation/json_annotation.dart';

part 'answers_request_model.g.dart';

/// Single item in the answers list for SubmissionCreateRequest
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AnswerItem {
  final String question;
  final List<String>? choices;
  final String? text;

  AnswerItem({
    required this.question,
    this.choices,
    this.text,
  });

  factory AnswerItem.fromJson(Map<String, dynamic> json) =>
      _$AnswerItemFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerItemToJson(this);
}

/// Request model matching NEW Swagger SubmissionCreateRequest
@JsonSerializable(explicitToJson: true)
class AnswersRequestModel {
  final List<AnswerItem> answers;

  AnswersRequestModel({required this.answers});

  factory AnswersRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['answers'] is List) {
      final rawList = json['answers'] as List;
      if (rawList.isNotEmpty && rawList.first is String) {
        // Fallback for legacy flat string array payloads
        final converted = rawList.map((e) => AnswerItem(question: e.toString())).toList();
        return AnswersRequestModel(answers: converted);
      }
    }
    return _$AnswersRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AnswersRequestModelToJson(this);
}

