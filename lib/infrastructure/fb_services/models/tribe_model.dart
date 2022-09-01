//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../cloud_storage/cloud_storage_services.dart';

TribeDb welcomeFromJson(String str) => TribeDb.fromJson(json.decode(str));

String welcomeToJson(TribeDb data) => json.encode(data.toJson());

class TribeDb {
  TribeDb({
    required this.tribeId,
    this.tribalName,
    this.customTribalSign,
    this.tribalIntroVideo,
    this.description,
    this.availableTime,
    this.triberer,
    this.triberersType,
    this.type,
    this.createdAt,
    this.localTribalSign,
  });

  String tribeId;
  FieldValue? createdAt;
  String? tribalName;
  UploadedFile? customTribalSign;
  String? localTribalSign;
  UploadedFile? tribalIntroVideo;
  String? description;
  String? triberersType;
  String? type;
  AvailableTime? availableTime;
  List<Triberer>? triberer;

  factory TribeDb.fromJson(Map<String, dynamic> json) => TribeDb(
        tribeId: json["tribe_id"],
        /* createdAt: json["createdAt"], */
        tribalName: json["tribal_name"],
        customTribalSign:json["custom_tribal_sign"] == null ?null :UploadedFile.fromJson(json["custom_tribal_sign"]),
        localTribalSign: json["localTribalSign"],
        tribalIntroVideo: UploadedFile.fromJson(json["tribal_intro_video"]),
        description: json["description"],
        triberersType:json["triberers_type"],
        type: json["type"],
        availableTime: AvailableTime.fromJson(json["availableTime"]),
        triberer: json["triberer"] == null
            ? null
            : (json["triberer"] as List<dynamic>)
                .map((x) => Triberer.fromJson(x))
                .toList(),


      );

  Map<String, dynamic> toJson() => {
        "tribe_id": tribeId,
        "createdAt": createdAt,
        "tribal_name": tribalName,
        "custom_tribal_sign": customTribalSign?.toJson(),
        "localTribalSign": localTribalSign,
        "tribal_intro_video": tribalIntroVideo?.toJson(),
        "description": description,
        "triberers_type": triberersType,
        "type": type,
        "availableTime": availableTime?.toJson(),
        "triberer": triberer?.map((x) => x.toJson()).toList(),
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

class Triberer {
  Triberer({
    required this.userId,
    required this.name,
    required this.profilePhoto,
    required this.motto,
    required this.role,
  });

  String userId;
  String name;
  String profilePhoto;
  String motto;
  String role;

  factory Triberer.fromJson(Map<String, dynamic> json) => Triberer(
        userId: json["userId"],
        name: json["name"],
        profilePhoto: json["profile_photo"],
        motto: json["motto"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "profile_photo": profilePhoto,
        "motto": motto,
        "role": role,
      };
}
