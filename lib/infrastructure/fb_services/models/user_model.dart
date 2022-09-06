// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// Package imports:
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../cloud_storage/cloud_storage_services.dart';

UserDB welcomeFromJson(String str) => UserDB.fromJson(json.decode(str));

String welcomeToJson(UserDB data) => json.encode(data.toJson());

class UserDB {
  UserDB({
    required this.userId,
    this.isInvited = false,
    this.createdAt,
    this.email,
    this.phoneNumber,
    this.name,
    this.requestedTribe,
    this.description,
    this.introVideoRef,
    this.lifeMotto,
    this.profilePhotoRef,
    this.hobbies,
    this.availableTime,
    this.attendedTribe,
    this.profileNotification,
  });
  bool isInvited;
  String userId;
  FieldValue? createdAt;
  String? email;
  String? phoneNumber;
  String? name;
  String? requestedTribe;
  String? description;
  UploadedFile? introVideoRef;
  String? lifeMotto;
  UploadedFile? profilePhotoRef;
  Hobbies? hobbies;
  AvailableTime? availableTime;
  AttendedTribe? attendedTribe;
  List<ProfileNotification>? profileNotification;

  factory UserDB.fromJson(Map<String, dynamic> json) => UserDB(
        userId: json["userId"],
        //TODO fieldvalue is not a timestamp
        /* createdAt: json["created_at"] as FieldValue, */
        /* isInvited: json["is_invited"] ?? false, */
        email: json["email"],
        phoneNumber: json["phone_number"],
        name: json["name"],
        requestedTribe: json["requested_tribe"],
        description: json["description"],
        introVideoRef: UploadedFile.fromJson(json["intro_video_url"]),
        lifeMotto: json["life_motto"],
        profilePhotoRef: UploadedFile.fromJson(json["profile_photo"]),
        hobbies: Hobbies.fromJson(json["hobbies"]),
        availableTime: AvailableTime.fromJson(json["available_time"]),
        /*  attendedTribe: AttendedTribe.fromJson(json["attended_tribe"]), */
        profileNotification: json["profile_notification"] == null
            ? null
            : (json["profile_notification"] as List<dynamic>)
                .map((e) => ProfileNotification.fromJson(e))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        /* "is_invited": isInvited, */
        "created_at": createdAt,
        "email": email,
        "phone_number": phoneNumber,
        "name": name,
        "requested_tribe": requestedTribe,
        "description": description,
        "intro_video_url": introVideoRef!.toJson(),
        "life_motto": lifeMotto,
        "profile_photo": profilePhotoRef!.toJson(),
        "hobbies": hobbies?.toJson(),
        "available_time": availableTime?.toJson(),
        "attended_tribe": attendedTribe?.toJson(),
        "profile_notification":
            profileNotification?.map((x) => x.toJson()).toList(),
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

class AvailableTime {
  AvailableTime({
    required this.startZero,
    required this.endZero,
    required this.timeZone,
    required this.start,
    required this.end,
  });

  int startZero;
  int endZero;
  String timeZone;
  int start;
  int end;

  factory AvailableTime.fromJson(Map<String, dynamic> json) => AvailableTime(
        startZero: json["start_zero"],
        endZero: json["end_zero"],
        timeZone: json["time_zone"],
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toJson() => {
        "start_zero": startZero,
        "end_zero": endZero,
        "time_zone": timeZone,
        "start": start,
        "end": end,
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
