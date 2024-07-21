// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestQuestion _$TestQuestionFromJson(Map<String, dynamic> json) => TestQuestion(
      (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['multipleQuestions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['comparisonQuestions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['contextQuestions'] as List<dynamic>)
          .map((e) => ContextQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestQuestionToJson(TestQuestion instance) =>
    <String, dynamic>{
      'questions': instance.questions,
      'multipleQuestions': instance.multipleQuestions,
      'comparisonQuestions': instance.comparisonQuestions,
      'contextQuestions': instance.contextQuestions,
    };
