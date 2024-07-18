// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      (json['id'] as num).toInt(),
      json['question'] as String?,
      json['multipleAnswers'] as bool?,
      json['type'] as String?,
      (json['checkedAnswers'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      (json['mediaFiles'] as List<dynamic>?)
          ?.map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['subOptions'] as List<dynamic>?)
          ?.map((e) => SubOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['answeredType'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'multipleAnswers': instance.multipleAnswers,
      'type': instance.type,
      'checkedAnswers': instance.checkedAnswers,
      'mediaFiles': instance.mediaFiles,
      'options': instance.options,
      'subOptions': instance.subOptions,
      'answeredType': instance.answeredType,
    };
