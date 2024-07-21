// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ent_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntTest _$EntTestFromJson(Map<String, dynamic> json) => EntTest(
      json['id'] as String,
      (json['questionsMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, TestQuestion.fromJson(e as Map<String, dynamic>)),
      ),
      json['type'] as String?,
      (json['timeLimitInMilliseconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EntTestToJson(EntTest instance) => <String, dynamic>{
      'id': instance.id,
      'questionsMap': instance.questionsMap,
      'type': instance.type,
      'timeLimitInMilliseconds': instance.timeLimitInMilliseconds,
    };
