// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

University _$UniversityFromJson(Map<String, dynamic> json) => University(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['address'] as String?,
      (json['middlePrice'] as num?)?.toInt(),
      json['status'] as String?,
      json['militaryDepartment'] as bool?,
      json['dormitory'] as bool?,
      json['description'] as String?,
      json['code'] as String?,
      (json['specializations'] as List<dynamic>?)
          ?.map((e) => Specialization.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      json['mediaFiles'] == null
          ? null
          : MediaFile.fromJson(json['mediaFiles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UniversityToJson(University instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'middlePrice': instance.middlePrice,
      'status': instance.status,
      'militaryDepartment': instance.militaryDepartment,
      'dormitory': instance.dormitory,
      'description': instance.description,
      'code': instance.code,
      'specializations': instance.specializations,
      'city': instance.city,
      'mediaFiles': instance.mediaFiles,
    };
