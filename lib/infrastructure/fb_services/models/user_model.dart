// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// Package imports:
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/app/modules/user_registration/models/country_model.dart';

import '../cloud_storage/cloud_storage_services.dart';

UserDB welcomeFromJson(String str) => UserDB.fromJson(json.decode(str));

String welcomeToJson(UserDB data) => json.encode(data.toJson());

class UserDB {
  UserDB({
    required this.userId,
    required this.profileNotification,
    this.isInvited = false,
    this.createdAt,
    this.email,
    this.phoneNumber,
    this.country,
    this.name,
    this.requestedTribe,
    this.description,
    this.introVideoRef,
    this.lifeMotto,
    this.profilePhotoRef,
    this.hobby,
    this.availableTime,
    this.attendedTribe,
  });
  UploadedFile? profilePhotoRef;
  bool isInvited;
  String userId;
  Object? createdAt;
  String? email;
  String? phoneNumber;
  Country? country;
  String? name;
  String? description;
  String? requestedTribe;
  String? lifeMotto;
  String? hobby;
  UploadedFile? introVideoRef;
  AvailableTime? availableTime;
  AttendedTribe? attendedTribe;
  List<Notification> profileNotification;

  static List<Notification> notyficationFromJson(
      List<dynamic> notyficationjson) {
    return (notyficationjson).map((e) => Notification.fromJson(e)).toList();
  }

  static Map<String, List<Map<String, dynamic>>> notyficationToJson(
      List<Notification> notyfication) {
    return {
      "profile_notification": notyfication.map((e) => e.toJson()).toList()
    };
  }

  factory UserDB.fromJson(Map<String, dynamic> json) => UserDB(
      userId: json["userId"],
      //TODO fieldvalue is not a timestamp
      createdAt: (json["created_at"] as Timestamp).toDate(),
      email: json["email"],
      phoneNumber: json["phone_number"],
      name: json["name"],
      country: Country.fromJson(json["country"]),
      requestedTribe: json["requested_tribe"],
      description: json["description"],
      introVideoRef: UploadedFile.fromJson(json["intro_video_url"]),
      lifeMotto: json["life_motto"],
      profilePhotoRef: UploadedFile.fromJson(json["profile_photo"]),
      hobby: json["hobby"],
      availableTime: AvailableTime.fromJson(json["available_time"]),
      profileNotification: notyficationFromJson(json["profile_notification"]));

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "created_at": createdAt,
        "email": email,
        "phone_number": phoneNumber,
        "name": name,
        "country": country?.toJson(),
        "requested_tribe": requestedTribe,
        "description": description,
        "intro_video_url": introVideoRef!.toJson(),
        "life_motto": lifeMotto,
        "profile_photo": profilePhotoRef!.toJson(),
        "hobby": hobby,
        "available_time": availableTime?.toJson(),
        "attended_tribe": attendedTribe?.toJson(),
        "profile_notification":
            profileNotification.map((e) => e.toJson()).toList(),
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

/* class Hobbies {
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
 */
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

/* class ProfileNotification {
  ProfileNotification({this.profileNotification = const <Notification>[]});

  List<Notification> profileNotification;

  /* factory ProfileNotification.fromJson(Map<String, dynamic> json) =>
      ProfileNotification(
        profileNotification: (json["profile_notification"] as List<dynamic>)
            .map((e) => Notification.fromJson(e))
            .toList(),
      ); */

  Map<String, dynamic> toJson() => {
        "profile_notification":

      };
} */

enum NotificationType { invited, accepted, rejected }

class Notification {
  Notification({
    required this.type,
    required this.tribeId,
    /* this.createdAt, */
  });

  NotificationType? type;
  String tribeId;
  /* Object? createdAt; */

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        type: NotificationType.values[(json["type"] as int)],
        tribeId: json["tribe_id"],
        //TODO problem with FieldValue.ServerTomeStamp and transaction
        /* createdAt: (json["created_at"] as Timestamp).toDate(), */
      );

  Map<String, dynamic> toJson() => {
        "type": type!.index,
        "tribe_id": tribeId,
        /* "created_at": createdAt, */
      };
}
