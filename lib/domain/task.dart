import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/media_file.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  int id;
  String? name;
  String? description;
  String? deadline;
  // ???? appTest;
  List<MediaFile> mediaFiles;
  @JsonKey(fromJson: _taskTypeEnumFromJson, toJson: _taskTypeEnumToJson)
  TaskTypeEnum? status;

  Task(this.id, this.name, this.description, this.deadline, this.mediaFiles, this.status);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

TaskTypeEnum? _taskTypeEnumFromJson(String? json) {
  if (json == null) return null;
  switch (json) {
    case 'OPEN':
      return TaskTypeEnum.OPEN;
    case 'OVERDUE':
      return TaskTypeEnum.OVERDUE;
    case 'ANSWERED':
      return TaskTypeEnum.ANSWERED;
    case 'CLOSED':
      return TaskTypeEnum.CLOSED;
    case 'CHECKED':
      return TaskTypeEnum.CHECKED;
    default:
      throw ArgumentError('Invalid TaskTypeEnum value: $json');
  }
}

String? _taskTypeEnumToJson(TaskTypeEnum? status) {
  if (status == null) return null;
  switch (status) {
    case TaskTypeEnum.OPEN:
      return 'OPEN';
    case TaskTypeEnum.OVERDUE:
      return 'OVERDUE';
    case TaskTypeEnum.ANSWERED:
      return 'ANSWERED';
    case TaskTypeEnum.CLOSED:
      return 'CLOSED';
    case TaskTypeEnum.CHECKED:
      return 'CHECKED';
    default:
      throw ArgumentError('Invalid TaskTypeEnum value: $status');
  }
}

enum TaskTypeEnum {
  OPEN,
  OVERDUE,
  ANSWERED,
  CLOSED,
  CHECKED
}
