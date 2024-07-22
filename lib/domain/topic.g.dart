// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['description'] as String?,
      json['appTest'] == null
          ? null
          : AppTest.fromJson(json['appTest'] as Map<String, dynamic>),
      json['task'] == null
          ? null
          : Task.fromJson(json['task'] as Map<String, dynamic>),
      json['video'] == null
          ? null
          : MediaFile.fromJson(json['video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'appTest': instance.appTest,
      'task': instance.task,
      'video': instance.video,
    };
