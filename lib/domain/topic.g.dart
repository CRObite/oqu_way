// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['description'] as String?,
      json['task'] == null
          ? null
          : Task.fromJson(json['task'] as Map<String, dynamic>),
      json['videoUrl'] as String?,
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'task': instance.task,
      'videoUrl': instance.videoUrl,
    };
