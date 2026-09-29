import 'package:json_annotation/json_annotation.dart';

part 'answers_questions_model.g.dart';

/// Represents the submission result matching NEW Swagger SubmissionResult
@JsonSerializable(explicitToJson: true)
class AnswersQuestionsModel {
  final String? id;
  final int score;

  @JsonKey(name: 'max_score')
  final int? maxScore;

  @JsonKey(name: 'pass_score')
  final int? passScore;

  @JsonKey(name: 'is_passed')
  final bool? isPassed;

  @JsonKey(name: 'submitted_at')
  final String? submittedAt;

  @JsonKey(name: 'has_pending_essays')
  final bool? hasPendingEssays;

  final Map<String, dynamic>? quiz;
  final List<Question> questions;

  @JsonKey(name: 'essay_answers')
  final List<EssayAnswerRef>? essayAnswers;

  AnswersQuestionsModel({
    this.id,
    required this.score,
    this.maxScore,
    this.passScore,
    this.isPassed,
    this.submittedAt,
    this.hasPendingEssays,
    this.quiz,
    required this.questions,
    this.essayAnswers,
  });

  factory AnswersQuestionsModel.fromJson(Map<String, dynamic> json) {
    List<Question> parsedQuestions = [];
    if (json['results'] is List) {
      parsedQuestions = (json['results'] as List)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (json['questions'] is List) {
      parsedQuestions = (json['questions'] as List)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    List<EssayAnswerRef>? parsedEssays;
    if (json['essay_answers'] is List) {
      parsedEssays = (json['essay_answers'] as List)
          .map((e) => EssayAnswerRef.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    final scoreVal = json['score'] is int
        ? json['score'] as int
        : int.tryParse(json['score']?.toString() ?? '0') ?? 0;

    return AnswersQuestionsModel(
      id: json['id']?.toString(),
      score: scoreVal,
      maxScore: json['max_score'] is int
          ? json['max_score'] as int
          : int.tryParse(json['max_score']?.toString() ?? ''),
      passScore: json['pass_score'] is int
          ? json['pass_score'] as int
          : int.tryParse(json['pass_score']?.toString() ?? ''),
      isPassed: json['is_passed'] as bool?,
      submittedAt: json['submitted_at']?.toString(),
      hasPendingEssays: json['has_pending_essays'] as bool?,
      quiz: json['quiz'] is Map<String, dynamic> ? json['quiz'] as Map<String, dynamic> : null,
      questions: parsedQuestions,
      essayAnswers: parsedEssays,
    );
  }

  Map<String, dynamic> toJson() => _$AnswersQuestionsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Question {
  final String id;
  final String body;

  @JsonKey(name: 'answered_correctly')
  final bool answeredCorrectly;

  final int? points;
  final int? earned;

  final List<Choice> choices;

  Question({
    required this.id,
    required this.body,
    required this.answeredCorrectly,
    this.points,
    this.earned,
    required this.choices,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final qId = json['id']?.toString() ?? json['question']?.toString() ?? '';
    final isCorrect = json['is_correct'] as bool? ?? json['answered_correctly'] as bool? ?? false;
    List<Choice> choiceList = [];
    if (json['choices'] is List) {
      choiceList = (json['choices'] as List)
          .map((e) => Choice.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return Question(
      id: qId,
      body: json['body']?.toString() ?? '',
      answeredCorrectly: isCorrect,
      points: json['points'] as int?,
      earned: json['earned'] as int?,
      choices: choiceList,
    );
  }

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Choice {
  final String id;
  final String body;

  @JsonKey(name: 'is_correct')
  final bool isCorrect;

  @JsonKey(name: 'is_answered')
  final bool isAnswered;

  Choice({
    required this.id,
    required this.body,
    required this.isCorrect,
    required this.isAnswered,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    final isCorr = json['is_correct'] as bool? ?? false;
    final isAns = json['selected'] as bool? ?? json['is_answered'] as bool? ?? false;
    return Choice(
      id: json['id']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      isCorrect: isCorr,
      isAnswered: isAns,
    );
  }

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}

/// Represents essay answer feedback from backend EssayAnswerRef schema
@JsonSerializable()
class EssayAnswerRef {
  final String? question;
  final String? body;
  final int? points;

  @JsonKey(name: 'answer_text')
  final String? answerText;

  @JsonKey(name: 'correct_answer')
  final String? correctAnswer;

  @JsonKey(name: 'points_awarded')
  final int? pointsAwarded;

  @JsonKey(name: 'graded_at')
  final String? gradedAt;

  EssayAnswerRef({
    this.question,
    this.body,
    this.points,
    this.answerText,
    this.correctAnswer,
    this.pointsAwarded,
    this.gradedAt,
  });

  factory EssayAnswerRef.fromJson(Map<String, dynamic> json) =>
      _$EssayAnswerRefFromJson(json);

  Map<String, dynamic> toJson() => _$EssayAnswerRefToJson(this);
}

