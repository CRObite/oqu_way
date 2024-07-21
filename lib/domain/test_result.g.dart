// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResult _$TestResultFromJson(Map<String, dynamic> json) => TestResult(
      (json['totalScore'] as num?)?.toInt(),
      (json['userScore'] as num?)?.toInt(),
      (json['percentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TestResultToJson(TestResult instance) =>
    <String, dynamic>{
      'totalScore': instance.totalScore,
      'userScore': instance.userScore,
      'percentage': instance.percentage,
    };
