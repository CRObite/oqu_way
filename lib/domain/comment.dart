import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/data/repository/comment_repository/comment_repository.dart';
import 'package:oqu_way/domain/app_user.dart';
import 'package:oqu_way/domain/post.dart';
import 'package:oqu_way/domain/specialization.dart';
import 'package:oqu_way/domain/university.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment{
  int id;
  String text;
  CommentType type;
  University? university;
  Post? post;
  Specialization? specialization;
  AppUser appUser;


  Comment(this.id, this.text, this.type, this.university, this.post,
      this.specialization, this.appUser);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}