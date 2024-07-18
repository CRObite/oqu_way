
import 'package:json_annotation/json_annotation.dart';

part 'sub_option.g.dart';

@JsonSerializable()
class SubOption{
  int id;
  String? text;

  SubOption(this.id, this.text);
  factory SubOption.fromJson(Map<String, dynamic> json) => _$SubOptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubOptionToJson(this);
}