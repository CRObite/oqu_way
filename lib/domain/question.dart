import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/media_file.dart';
import 'package:oqu_way/domain/sub_option.dart';

import 'option.dart';

part 'question.g.dart';

@JsonSerializable()
class Question{
  int id;
  String? question;
  bool? multipleAnswers;
  String? type;
  List<int>? checkedAnswers;
  List<MediaFile>? mediaFiles;
  List<Option>? options;
  List<SubOption>? subOptions;
  String? answeredType;

  Question(this.id, this.question, this.multipleAnswers, this.type, this.checkedAnswers,
      this.mediaFiles, this.options, this.subOptions, this.answeredType);

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}


enum QuestionCorrectionType{
  FULL_CORRECTLY, HALF_CORRECTLY, NO_CORRECT
}