
import 'package:json_annotation/json_annotation.dart';

part 'total_result.g.dart';

@JsonSerializable()
class TotalResult{
  int maxScore;
  int score;
  List<String>? subjectNames;

  TotalResult(this.maxScore, this.score, this.subjectNames);


  factory TotalResult.fromJson(Map<String, dynamic> json) => _$TotalResultFromJson(json);
  Map<String, dynamic> toJson() => _$TotalResultToJson(this);
}
