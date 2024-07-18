// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      (json['id'] as num).toInt(),
      json['text'] as String?,
      json['isRight'] as bool?,
      json['checked'] as bool?,
      json['subOption'] == null
          ? null
          : SubOption.fromJson(json['subOption'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'isRight': instance.isRight,
      'checked': instance.checked,
      'subOption': instance.subOption,
    };
