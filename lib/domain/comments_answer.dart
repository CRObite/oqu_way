import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/app_user.dart';
import 'package:oqu_way/domain/comment.dart';
part 'comments_answer.g.dart';

@JsonSerializable()
class CommentsAnswer{
  int id;
  String text;
  Comment comment;
  AppUser appUser;

  CommentsAnswer(this.id, this.text, this.comment, this.appUser);

  factory CommentsAnswer.fromJson(Map<String, dynamic> json) => _$CommentsAnswerFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsAnswerToJson(this);
}