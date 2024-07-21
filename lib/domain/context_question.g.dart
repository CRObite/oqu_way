// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContextQuestion _$ContextQuestionFromJson(Map<String, dynamic> json) =>
    ContextQuestion(
      json['content'] as String,
      (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContextQuestionToJson(ContextQuestion instance) =>
    <String, dynamic>{
      'content': instance.content,
      'questions': instance.questions,
    };
