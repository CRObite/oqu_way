// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskAnswer _$TaskAnswerFromJson(Map<String, dynamic> json) => TaskAnswer(
      (json['id'] as num).toInt(),
      json['description'] as String?,
      json['teacherComment'] as String?,
      (json['score'] as num?)?.toDouble(),
      (json['mediaFiles'] as List<dynamic>)
          .map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskAnswerToJson(TaskAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'teacherComment': instance.teacherComment,
      'score': instance.score,
      'mediaFiles': instance.mediaFiles,
    };
