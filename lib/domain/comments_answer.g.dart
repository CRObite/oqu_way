// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsAnswer _$CommentsAnswerFromJson(Map<String, dynamic> json) =>
    CommentsAnswer(
      (json['id'] as num).toInt(),
      json['text'] as String,
      Comment.fromJson(json['comment'] as Map<String, dynamic>),
      AppUser.fromJson(json['appUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentsAnswerToJson(CommentsAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'comment': instance.comment,
      'appUser': instance.appUser,
    };
