// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      (json['percentage'] as num?)?.toDouble(),
      (json['modules'] as List<dynamic>)
          .map((e) => Module.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentage': instance.percentage,
      'modules': instance.modules,
    };
