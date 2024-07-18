import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/sub_option.dart';

part 'option.g.dart';

@JsonSerializable()
class Option{
  int id;
  String? text;
  bool? isRight;
  bool? checked;
  SubOption? subOption;

  Option(this.id, this.text, this.isRight, this.checked, this.subOption);

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionToJson(this);
}