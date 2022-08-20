//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

TribeDb welcomeFromJson(String str) => TribeDb.fromJson(json.decode(str));

String welcomeToJson(TribeDb data) => json.encode(data.toJson());

class TribeDb {
  TribeDb(
      {required this.tribeId,
      this.tribalName,
      this.tribalSign,
      this.tribalIntroVideo,
      this.description,
      this.weeklySuggestedTime,
      this.triberer,
      this.type});

  String tribeId;
  String? tribalName;
  UploadedFile? tribalSign;
  UploadedFile? tribalIntroVideo;
  String? description;
  String? type;
  WeeklySuggestedTime? weeklySuggestedTime;
  List<Triberer>? triberer;

  factory TribeDb.fromJson(Map<String, dynamic> json) => TribeDb(
        tribeId: json["tribe_id"],
        tribalName: json["tribal_name"],
        tribalSign: json["tribal_sign"],
        tribalIntroVideo: json["tribal_intro_video"],
        description: json["description"],
        type: json["type"],
        weeklySuggestedTime: json["weekly_suggested_time"],
        triberer: List<Triberer>.from(
            json["triberer"].map((x) => Triberer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tribe_id": tribeId,
        "tribal_name": tribalName,
        "tribal_sign": tribalSign,
        "tribal_intro_video": tribalIntroVideo,
        "description": description,
        "type": type,
        "weekly_suggested_time": weeklySuggestedTime,
        "triberer": triberer?.map((x) => x.toJson()).toList(),
      };
}

class UploadedFile {
  UploadedFile({
    required this.downloadUrl,
    required this.metaData,
  });

  String downloadUrl;
  Metadata metaData;

  factory UploadedFile.fromJson(Map<String, dynamic> json) => UploadedFile(
        downloadUrl: json["downloadUrl"],
        metaData: Metadata.fromJson(json["metaData"]),
      );

  Map<String, dynamic> toJson() => {
        "downloadUrl": downloadUrl,
        "metaData": metaData.toJson(),
      };
}

class WeeklySuggestedTime {
  WeeklySuggestedTime({
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

  factory WeeklySuggestedTime.fromJson(Map<String, dynamic> json) =>
      WeeklySuggestedTime(
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

class Metadata {
  Metadata({
    required this.bucket,
    required this.name,
    required this.size,
    required this.fullPath,
    required this.contentType,
    required this.timeCreated,
    required this.contentEncoding,
  });

  final String? bucket;
  final String fullPath;
  final int size;
  final DateTime? timeCreated;
  final String contentType;
  final String? contentEncoding;
  final String name;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        bucket: json["bucket"],
        fullPath: json["fullPath"],
        size: json["size"],
        timeCreated: ((json["timeCreated"]) as Timestamp).toDate(),
        contentType: json["contentType"],
        contentEncoding: json["contentEncoding"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "bucket": bucket,
        "fullPath": fullPath,
        "size": size,
        "timeCreated": timeCreated,
        "contentType": contentType,
        "contentEncoding": contentEncoding,
        "name": name,
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
