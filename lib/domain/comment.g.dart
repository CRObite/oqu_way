// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      (json['id'] as num).toInt(),
      json['text'] as String,
      $enumDecode(_$CommentTypeEnumMap, json['type']),
      json['university'] == null
          ? null
          : University.fromJson(json['university'] as Map<String, dynamic>),
      json['post'] == null
          ? null
          : Post.fromJson(json['post'] as Map<String, dynamic>),
      json['specialization'] == null
          ? null
          : Specialization.fromJson(
              json['specialization'] as Map<String, dynamic>),
      AppUser.fromJson(json['appUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'type': _$CommentTypeEnumMap[instance.type]!,
      'university': instance.university,
      'post': instance.post,
      'specialization': instance.specialization,
      'appUser': instance.appUser,
    };

const _$CommentTypeEnumMap = {
  CommentType.Post: 'Post',
  CommentType.University: 'University',
  CommentType.Specialization: 'Specialization',
};
