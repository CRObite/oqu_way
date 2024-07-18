
import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/app_test.dart';
import 'package:oqu_way/domain/task.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic{
  int id;
  String? name;
  String? description;
  AppTest? appTest;
  Task? task;
  String? videoUrl;


  Topic(this.id, this.name, this.description, this.appTest, this.task,
      this.videoUrl);

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}