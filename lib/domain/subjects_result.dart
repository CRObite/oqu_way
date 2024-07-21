
import 'package:json_annotation/json_annotation.dart';

part 'subjects_result.g.dart';

@JsonSerializable()
class SubjectsResult{
  String subjectName;
  int maxScore;
  int score;

  SubjectsResult(this.subjectName, this.maxScore, this.score);


  factory SubjectsResult.fromJson(Map<String, dynamic> json) => _$SubjectsResultFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectsResultToJson(this);
}