import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/module.dart';

part 'subject.g.dart';

@JsonSerializable()
class Subject {
  int id;
  String? name;
  double? percentage;
  List<Module> modules;


  Subject(this.id, this.name, this.percentage, this.modules);

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}