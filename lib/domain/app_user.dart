
import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser{
  int id;
  String? firstName;
  String? lastName;
  String? login;

  AppUser(this.id, this.firstName, this.lastName, this.login);

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}