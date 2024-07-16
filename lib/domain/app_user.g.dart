// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      (json['id'] as num).toInt(),
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['email'] as String?,
      json['iin'] as String?,
      json['login'] as String?,
      json['phoneNumber'] as String?,
      (json['coins'] as num?)?.toInt(),
      json['avatar'] as String?,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'iin': instance.iin,
      'login': instance.login,
      'phoneNumber': instance.phoneNumber,
      'coins': instance.coins,
      'avatar': instance.avatar,
    };
