// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppTest _$AppTestFromJson(Map<String, dynamic> json) => AppTest(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      (json['mediaFiles'] as List<dynamic>?)
          ?.map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['description'] as String?,
      json['deadline'] as String?,
      (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as String?,
    );

Map<String, dynamic> _$AppTestToJson(AppTest instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mediaFiles': instance.mediaFiles,
      'description': instance.description,
      'deadline': instance.deadline,
      'questions': instance.questions,
      'status': instance.status,
    };
