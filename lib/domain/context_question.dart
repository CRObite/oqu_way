import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/question.dart';


part 'context_question.g.dart';

@JsonSerializable()
class ContextQuestion{
  String content;
  List<Question> questions;

  ContextQuestion(this.content, this.questions);

  factory ContextQuestion.fromJson(Map<String, dynamic> json) => _$ContextQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$ContextQuestionToJson(this);
}