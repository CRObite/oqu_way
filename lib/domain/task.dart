import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/media_file.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  int id;
  String? name;
  String? description;
  String? deadline;
  List<MediaFile> mediaFiles;
  String? status;

  Task(this.id, this.name, this.description, this.deadline, this.mediaFiles, this.status);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

enum TaskTypeEnum {
  OPEN,
  OVERDUE,
  ANSWERED,
  CLOSED,
  CHECKED
}
