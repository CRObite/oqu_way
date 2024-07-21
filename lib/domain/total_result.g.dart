// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalResult _$TotalResultFromJson(Map<String, dynamic> json) => TotalResult(
      (json['maxScore'] as num).toInt(),
      (json['score'] as num).toInt(),
      (json['subjectNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TotalResultToJson(TotalResult instance) =>
    <String, dynamic>{
      'maxScore': instance.maxScore,
      'score': instance.score,
      'subjectNames': instance.subjectNames,
    };
