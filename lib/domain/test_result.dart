
import 'package:json_annotation/json_annotation.dart';

part 'test_result.g.dart';

@JsonSerializable()
class TestResult{
  int? totalScore;
  int? userScore;
  double? percentage;

  TestResult(this.totalScore, this.userScore, this.percentage);

  factory TestResult.fromJson(Map<String, dynamic> json) => _$TestResultFromJson(json);
  Map<String, dynamic> toJson() => _$TestResultToJson(this);
}