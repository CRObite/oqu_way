import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/question.dart';
import 'package:oqu_way/domain/test_question.dart';

import 'media_file.dart';

part 'ent_test.g.dart';

@JsonSerializable()
class EntTest{
  String id;
  Map<String,TestQuestion> questionsMap;
  String? type;
  int? timeLimitInMilliseconds;


  EntTest(
      this.id,
      this.questionsMap,
      this.type,
      this.timeLimitInMilliseconds);

  factory EntTest.fromJson(Map<String, dynamic> json) => _$EntTestFromJson(json);
  Map<String, dynamic> toJson() => _$EntTestToJson(this);
}