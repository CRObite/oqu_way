import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/question.dart';

import 'context_question.dart';
part 'test_question.g.dart';

@JsonSerializable()
class TestQuestion{
  List<Question> questions;
  List<Question> multipleQuestions;
  List<Question> comparisonQuestions;
  List<ContextQuestion> contextQuestions;

  TestQuestion(this.questions, this.multipleQuestions, this.comparisonQuestions,
      this.contextQuestions);

  factory TestQuestion.fromJson(Map<String, dynamic> json) => _$TestQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$TestQuestionToJson(this);
}

