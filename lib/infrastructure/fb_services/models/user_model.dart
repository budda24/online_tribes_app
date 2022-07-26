// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserDB welcomeFromJson(String str) => UserDB.fromJson(json.decode(str));

String welcomeToJson(UserDB data) => json.encode(data.toJson());

class UserDB {
  UserDB({
    required this.userId,
    this.email,
    this.phoneNumber,
    this.name,
    this.requestedTribe,
    this.description,
    this.introVideoUrl,
    this.lifeMotto,
    this.profilePhoto,
    this.hobbies,
    this.timeToInvest,
    this.attendedTribe,
    this.profileNotification,
  });

  String userId;
  String? email;
  
  String? phoneNumber;
  String? name;
  String? requestedTribe;
  String? description;
  String? introVideoUrl;
  String? lifeMotto;
  String? profilePhoto;
  Hobbies? hobbies;
  int? timeToInvest;
  AttendedTribe? attendedTribe;
  List<ProfileNotification>? profileNotification;

  factory UserDB.fromJson(Map<String, dynamic> json) => UserDB(
        userId: json["userId"],
        email: json["email"],
        name: json["name"],
        requestedTribe: json["requested_tribe"],
        description: json["description"],
        introVideoUrl: json["intro_video_url"],
        lifeMotto: json["life_motto"],
        profilePhoto: json["profile_photo"],
        hobbies: Hobbies.fromJson(json["hobbies"]),
        timeToInvest: json["time_to_invest"],
        /*  attendedTribe: AttendedTribe.fromJson(json["attended_tribe"]), */
        profileNotification: (json["profile_notification"] as List<dynamic>)
            .map((e) => ProfileNotification.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "name": name,
        "requested_tribe": requestedTribe,
        "description": description,
        "intro_video_url": introVideoUrl,
        "life_motto": lifeMotto,
        "profile_photo": profilePhoto,
        "hobbies": hobbies?.toJson(),
        "time_to_invest": timeToInvest,
        "attended_tribe": attendedTribe?.toJson(),
        "profile_notification":
            List<dynamic>.from(profileNotification!.map((x) => x.toJson())),
      };
}

class AttendedTribe {
  AttendedTribe({
    required this.tribeId,
    required this.role,
  });

  String tribeId;
  String role;

  factory AttendedTribe.fromJson(Map<String, dynamic> json) => AttendedTribe(
        tribeId: json["tribe_id"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "tribe_id": tribeId,
        "role": role,
      };
}

class Hobbies {
  Hobbies({
    required this.hobby,
    required this.hobby1,
  });

  String hobby;
  String hobby1;

  factory Hobbies.fromJson(Map<String, dynamic> json) => Hobbies(
        hobby: json["hobby"],
        hobby1: json["hobby1"],
      );

  Map<String, dynamic> toJson() => {
        "hobby": hobby,
        "hobby1": hobby1,
      };
}

class ProfileNotification {
  ProfileNotification({
    required this.type,
    required this.tribeId,
    required this.createdAt,
  });

  String type;
  String tribeId;
  DateTime createdAt;

  factory ProfileNotification.fromJson(Map<String, dynamic> json) =>
      ProfileNotification(
        type: json["type"],
        tribeId: json["tribe_id"],
        createdAt: ((json["created_at"]) as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "tribe_id": tribeId,
        "created_at": createdAt,
      };
}
