import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/region.dart';

part 'city.g.dart';

@JsonSerializable()
class City{
  int id;
  String name;
  Region? region;

  City(this.id, this.name, this.region);

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}