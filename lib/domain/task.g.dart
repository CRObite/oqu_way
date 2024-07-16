// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['description'] as String?,
      json['deadline'] as String?,
      (json['mediaFiles'] as List<dynamic>)
          .map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      _taskTypeEnumFromJson(json['status'] as String?),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'deadline': instance.deadline,
      'mediaFiles': instance.mediaFiles,
      'status': _taskTypeEnumToJson(instance.status),
    };
