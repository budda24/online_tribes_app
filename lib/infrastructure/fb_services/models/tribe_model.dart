//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
      required this.tribeId,
      required  this.tribalName,
      required  this.tribalSign,
      required  this.tribalIntroVideo,
       required this.description,
       required this.weeklySuggestedTime,
        this.triberer,
    });

    String tribeId;
    String tribalName;
    UploadedFile tribalSign;
    UploadedFile tribalIntroVideo;
    String description;
    DateTime weeklySuggestedTime;
    List<Triberer>? triberer;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        tribeId: json["tribe_id"],
        tribalName: json["tribal_name"],
        tribalSign: json["tribal_sign"],
        tribalIntroVideo: json["tribal_intro_video"],
        description: json["description"],
        weeklySuggestedTime: json["weekly_suggested_time"],
        triberer: List<Triberer>.from(json["triberer"].map((x) => Triberer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tribe_id": tribeId,
        "tribal_name": tribalName,
        "tribal_sign": tribalSign,
        "tribal_intro_video": tribalIntroVideo,
        "description": description,
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
        metaData:Metadata.fromJson(json["metaData"]),
      );

  Map<String, dynamic> toJson() => {
        "downloadUrl": downloadUrl,
        "metaData": metaData.toJson(),
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
        timeCreated:((json["timeCreated"]) as Timestamp).toDate(),
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
