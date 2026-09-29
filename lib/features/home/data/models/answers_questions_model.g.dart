// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_questions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswersQuestionsModel _$AnswersQuestionsModelFromJson(
  Map<String, dynamic> json,
) => AnswersQuestionsModel(
  id: json['id'] as String?,
  score: (json['score'] as num).toInt(),
  maxScore: (json['max_score'] as num?)?.toInt(),
  passScore: (json['pass_score'] as num?)?.toInt(),
  isPassed: json['is_passed'] as bool?,
  submittedAt: json['submitted_at'] as String?,
  hasPendingEssays: json['has_pending_essays'] as bool?,
  quiz: json['quiz'] as Map<String, dynamic>?,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => Question.fromJson(e as Map<String, dynamic>))
      .toList(),
  essayAnswers: (json['essay_answers'] as List<dynamic>?)
      ?.map((e) => EssayAnswerRef.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AnswersQuestionsModelToJson(
  AnswersQuestionsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'score': instance.score,
  'max_score': instance.maxScore,
  'pass_score': instance.passScore,
  'is_passed': instance.isPassed,
  'submitted_at': instance.submittedAt,
  'has_pending_essays': instance.hasPendingEssays,
  'quiz': instance.quiz,
  'questions': instance.questions.map((e) => e.toJson()).toList(),
  'essay_answers': instance.essayAnswers?.map((e) => e.toJson()).toList(),
};

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
  id: json['id'] as String,
  body: json['body'] as String,
  answeredCorrectly: json['answered_correctly'] as bool,
  points: (json['points'] as num?)?.toInt(),
  earned: (json['earned'] as num?)?.toInt(),
  choices: (json['choices'] as List<dynamic>)
      .map((e) => Choice.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
  'id': instance.id,
  'body': instance.body,
  'answered_correctly': instance.answeredCorrectly,
  'points': instance.points,
  'earned': instance.earned,
  'choices': instance.choices.map((e) => e.toJson()).toList(),
};

Choice _$ChoiceFromJson(Map<String, dynamic> json) => Choice(
  id: json['id'] as String,
  body: json['body'] as String,
  isCorrect: json['is_correct'] as bool,
  isAnswered: json['is_answered'] as bool,
);

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
  'id': instance.id,
  'body': instance.body,
  'is_correct': instance.isCorrect,
  'is_answered': instance.isAnswered,
};

EssayAnswerRef _$EssayAnswerRefFromJson(Map<String, dynamic> json) =>
    EssayAnswerRef(
      question: json['question'] as String?,
      body: json['body'] as String?,
      points: (json['points'] as num?)?.toInt(),
      answerText: json['answer_text'] as String?,
      correctAnswer: json['correct_answer'] as String?,
      pointsAwarded: (json['points_awarded'] as num?)?.toInt(),
      gradedAt: json['graded_at'] as String?,
    );

Map<String, dynamic> _$EssayAnswerRefToJson(EssayAnswerRef instance) =>
    <String, dynamic>{
      'question': instance.question,
      'body': instance.body,
      'points': instance.points,
      'answer_text': instance.answerText,
      'correct_answer': instance.correctAnswer,
      'points_awarded': instance.pointsAwarded,
      'graded_at': instance.gradedAt,
    };
