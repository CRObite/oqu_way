
import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser{
  int id;
  String? firstName;
  String? lastName;
  String? email;
  String? iin;
  String? login;
  String? phoneNumber;
  int? coins;
  String? avatar;



  AppUser(this.id, this.firstName, this.lastName, this.email, this.iin,
      this.login, this.phoneNumber, this.coins, this.avatar);

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}