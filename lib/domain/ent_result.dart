import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/subjects_result.dart';
import 'package:oqu_way/domain/total_result.dart';

part 'ent_result.g.dart';

@JsonSerializable()
class EntResult{
  TotalResult totalResult;
  List<SubjectsResult> subjectsResult;

  EntResult(this.totalResult, this.subjectsResult);

  factory EntResult.fromJson(Map<String, dynamic> json) => _$EntResultFromJson(json);
  Map<String, dynamic> toJson() => _$EntResultToJson(this);
}

