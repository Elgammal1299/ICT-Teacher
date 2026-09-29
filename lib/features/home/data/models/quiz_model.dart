import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_model.g.dart';

@JsonSerializable(explicitToJson: true, createFactory: false)
class QuizModel {
  final String? id;
  final String? title;

  @JsonKey(name: 'quiz_type')
  final String? quizType;

  @JsonKey(name: 'pass_score')
  final int? passScore;

  @JsonKey(name: 'max_score')
  final int? maxScore;

  final Map<String, dynamic>? term;
  final Map<String, dynamic>? content;
  final List<QuestionModel>? questions;

  final AnswersQuestionsModel? submission;

  QuizModel({
    this.id,
    this.title,
    this.quizType,
    this.passScore,
    this.maxScore,
    this.term,
    this.content,
    this.questions,
    this.submission,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    AnswersQuestionsModel? sub;
    if (json['submission'] != null && json['submission'] is Map<String, dynamic>) {
      try {
        sub = AnswersQuestionsModel.fromJson(json['submission'] as Map<String, dynamic>);
      } catch (_) {}
    }
    return QuizModel(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      quizType: json['quiz_type']?.toString(),
      passScore: json['pass_score'] is int ? json['pass_score'] as int : int.tryParse(json['pass_score']?.toString() ?? ''),
      maxScore: json['max_score'] is int ? json['max_score'] as int : int.tryParse(json['max_score']?.toString() ?? ''),
      term: json['term'] is Map<String, dynamic> ? json['term'] as Map<String, dynamic> : null,
      content: json['content'] is Map<String, dynamic> ? json['content'] as Map<String, dynamic> : null,
      questions: json['questions'] is List
          ? (json['questions'] as List)
              .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      submission: sub,
    );
  }

  Map<String, dynamic> toJson() => _$QuizModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuestionModel {
  final String? id;
  final String? body;

  @JsonKey(name: 'question_type')
  final String? questionType;

  final bool? multiple;
  final int? points;
  final String? figure;

  @JsonKey(name: 'order_number')
  final int? orderNumber;

  final List<ChoiceModel>? choices;

  QuestionModel({
    this.id,
    this.body,
    this.questionType,
    this.multiple,
    this.points,
    this.figure,
    this.orderNumber,
    this.choices,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable()
class ChoiceModel {
  final String? id;
  final String? body;
  final String? figure;

  @JsonKey(name: 'order_number')
  final int? orderNumber;

  ChoiceModel({
    this.id,
    this.body,
    this.figure,
    this.orderNumber,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceModelToJson(this);
}

