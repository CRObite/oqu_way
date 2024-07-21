// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specialization _$SpecializationFromJson(Map<String, dynamic> json) =>
    Specialization(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      (json['grandScore'] as num?)?.toInt(),
      (json['grandCount'] as num?)?.toInt(),
      (json['averageSalary'] as num?)?.toInt(),
      json['demand'] as String?,
      json['code'] as String?,
      json['description'] as String?,
      (json['subjects'] as List<dynamic>?)
          ?.map((e) => Subject.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['universities'] as List<dynamic>?)
          ?.map((e) => University.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['possibilityChance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SpecializationToJson(Specialization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'grandScore': instance.grandScore,
      'grandCount': instance.grandCount,
      'averageSalary': instance.averageSalary,
      'demand': instance.demand,
      'code': instance.code,
      'description': instance.description,
      'subjects': instance.subjects,
      'universities': instance.universities,
      'possibilityChance': instance.possibilityChance,
    };
