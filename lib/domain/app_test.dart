import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/question.dart';

import 'media_file.dart';

part 'app_test.g.dart';

@JsonSerializable()
class AppTest{
  int id;
  String? name;
  List<MediaFile>? mediaFiles;
  String? description;
  String? deadline;
  List<Question>? questions;
  String? status;


  AppTest(
      this.id,
      this.name,
      this.mediaFiles,
      this.description,
      this.deadline,
      this.questions,
      this.status);

  factory AppTest.fromJson(Map<String, dynamic> json) => _$AppTestFromJson(json);
  Map<String, dynamic> toJson() => _$AppTestToJson(this);
}