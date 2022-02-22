// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.tribalName,
    required this.email,
    this.createdAt,
  });

  String? id;
  String? tribalName;
  String email;

  dynamic createdAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"]??'',
        tribalName: json["name"]??'',
        email: json["email"]??'',
        createdAt: json["createdAt"]??'',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tribalName": tribalName,
        "email": email,
        "createdAt": createdAt,
      };
}
