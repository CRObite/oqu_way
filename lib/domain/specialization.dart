import 'package:json_annotation/json_annotation.dart';
import 'package:oqu_way/domain/subject.dart';
import 'package:oqu_way/domain/university.dart';

part 'specialization.g.dart';

@JsonSerializable()
class Specialization {
  int id;
  String? name;
  int? grandScore;
  int? grandCount;
  int? averageSalary;
  String? demand;
  String? code;
  String? description;
  List<Subject>? subjects;
  List<University>? universities;
  double?  possibilityChance;

  Specialization(
      this.id,
      this.name,
      this.grandScore,
      this.grandCount,
      this.averageSalary,
      this.demand,
      this.code,
      this.description,
      this.subjects,
      this.universities,
      this.possibilityChance);

  factory Specialization.fromJson(Map<String, dynamic> json) => _$SpecializationFromJson(json);
  Map<String, dynamic> toJson() => _$SpecializationToJson(this);
}