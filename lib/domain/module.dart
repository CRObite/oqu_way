

import 'package:json_annotation/json_annotation.dart';

import 'topic.dart';

part 'module.g.dart';

@JsonSerializable()
class Module{
  int id;
  String? name;
  List<Topic> topics;
  double? percentage;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool opened = false;

  Module(this.id, this.name, this.topics, this.percentage);

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleToJson(this);



}