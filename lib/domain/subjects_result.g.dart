// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjects_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectsResult _$SubjectsResultFromJson(Map<String, dynamic> json) =>
    SubjectsResult(
      json['subjectName'] as String,
      (json['maxScore'] as num).toInt(),
      (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$SubjectsResultToJson(SubjectsResult instance) =>
    <String, dynamic>{
      'subjectName': instance.subjectName,
      'maxScore': instance.maxScore,
      'score': instance.score,
    };
