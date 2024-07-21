
import 'package:json_annotation/json_annotation.dart';

import 'media_file.dart';

part 'task_answer.g.dart';

@JsonSerializable()
class TaskAnswer{
  int id;
  String? description;
  String? teacherComment;
  double? score;
  List<MediaFile> mediaFiles;

  TaskAnswer(this.id, this.description, this.teacherComment, this.score, this.mediaFiles);


  factory TaskAnswer.fromJson(Map<String, dynamic> json) => _$TaskAnswerFromJson(json);
  Map<String, dynamic> toJson() => _$TaskAnswerToJson(this);
}