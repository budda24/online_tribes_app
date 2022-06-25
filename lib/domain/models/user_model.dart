// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.userId,
    this.createdAt,
    this.email,
    this.name,
    this.requestedTribe,
    this.description,
    this.introVideoUrl,
    this.lifeMotto,
    this.profilePhoto,
    this.hobbies,
    this.timeToInvest,
    this.attendedTribe,
    this.userNotification,
  });

  String userId;
  FieldValue? createdAt;
  String? email;
  String? name;
  String? requestedTribe;
  String? description;
  String? introVideoUrl;
  String? lifeMotto;
  String? profilePhoto;
  Hobbies? hobbies;
  int? timeToInvest;
  AttendedTribe? attendedTribe;
  UserNotification? userNotification;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        name: json["name"],
        requestedTribe: json["requested_tribe"],
        description: json["description"],
        introVideoUrl: json["intro_video_url"],
        lifeMotto: json["life_motto"],
        profilePhoto: json["profile_photo"],
        hobbies: Hobbies.fromJson(json["hobbies"]),
        timeToInvest: json["time_to_invest"],
        attendedTribe: AttendedTribe.fromJson(json["attended_tribe"]),
        userNotification: UserNotification.fromJson(json["user_notification"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "requested_tribe": requestedTribe,
        "description": description,
        "intro_video_url": introVideoUrl,
        "life_motto": lifeMotto,
        "profile_photo": profilePhoto,
        "hobbies": hobbies!.toJson(),
        "time_to_invest": timeToInvest,
        "attended_tribe": attendedTribe!.toJson(),
        "user_notification": userNotification!.toJson(),
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

class UserNotification {
  UserNotification({
    this.tribalRequest,
    this.acceptedRequest,
    this.rejectedRequest,
  });

  Request? tribalRequest;
  Request? acceptedRequest;
  RejectedRequest? rejectedRequest;

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      UserNotification(
        tribalRequest: Request.fromJson(json["tribal_request"]),
        acceptedRequest: Request.fromJson(json["accepted_request"]),
        rejectedRequest: RejectedRequest.fromJson(json["rejected_request"]),
      );

  Map<String, dynamic> toJson() => {
        "tribal_request": tribalRequest!.toJson(),
        "accepted_request": acceptedRequest!.toJson(),
        "rejected_request": rejectedRequest!.toJson(),
      };
}

class Request {
  Request({
    required this.tribeId,
  });

  String tribeId;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        tribeId: json["tribe_id"],
      );

  Map<String, dynamic> toJson() => {
        "tribe_id": tribeId,
      };
}

class RejectedRequest {
  RejectedRequest({
    required this.tribeId,
  });

  TribeId tribeId;

  factory RejectedRequest.fromJson(Map<String, dynamic> json) =>
      RejectedRequest(
        tribeId: TribeId.fromJson(json["tribe_id"]),
      );

  Map<String, dynamic> toJson() => {
        "tribe_id": tribeId.toJson(),
      };
}

class TribeId {
  TribeId();

  factory TribeId.fromJson(Map<String, dynamic> json) => TribeId();

  Map<String, dynamic> toJson() => {};
}
