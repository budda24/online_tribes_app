// To parse this JSON data, do
//
//     final userDb = userDbFromJson(jsonString);

import 'dart:convert';

UserDB userDbFromJson(String str) => UserDB.fromJson(json.decode(str));

String userDbToJson(UserDB data) => json.encode(data.toJson());

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
    this.createdAt,
  });

  String userId;
  String? email;
  String? phoneNumber;
  String? name;
  dynamic createdAt;
  String? requestedTribe;
  String? description;
  String? introVideoUrl;
  String? lifeMotto;
  /* String? hobby; */
  String? profilePhoto;
  Hobbies? hobbies;
  int? timeToInvest;
  AttendedTribe? attendedTribe;
  ProfileNotification? profileNotification;

  factory UserDB.fromJson(Map<String, dynamic> json) => UserDB(
        userId: json["userId"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        name: json["name"],
        createdAt: json["createdAt"],
        /* requestedTribe: json["requested_tribe"], */
        description: json["description"],
        introVideoUrl: json["intro_video_url"],
        lifeMotto: json["life_motto"],
        profilePhoto: json["profile_photo"],
        hobbies: Hobbies.fromJson(json["hobbies"]),
        timeToInvest: json["time_to_invest"],
        /* attendedTribe: AttendedTribe?.fromJson(json["attended_tribe"]), */
        /* profileNotification:
            ProfileNotification?.fromJson(json["profile_notification"]), */
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "name": name,
        "phone_number": phoneNumber,
        "createdAt": createdAt,
        "requested_tribe": requestedTribe,
        "description": description,
        "intro_video_url": introVideoUrl,
        "life_motto": lifeMotto,
        "profile_photo": profilePhoto,
        /* "hobby": hobby, */
        "hobbies": hobbies?.toJson(),
        "time_to_invest": timeToInvest,
        "attended_tribe": attendedTribe?.toJson(),
        "profile_notification": profileNotification?.toJson(),
      };
}

class AttendedTribe {
  AttendedTribe({
    this.tribeId,
    this.role,
  });

  String? tribeId;
  String? role;

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
    this.hobby1,
  });

  String hobby;
  String? hobby1;

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
    this.tribalRequest,
    this.acceptedRequest,
    this.rejectedRequest,
  });

  List<Request>? tribalRequest;
  List<Request>? acceptedRequest;
  List<Request>? rejectedRequest;

  factory ProfileNotification.fromJson(Map<String, dynamic> json) =>
      ProfileNotification(
        tribalRequest: List<Request>.from(
            json["tribal_request"].map((x) => Request.fromJson(x))),
        acceptedRequest: List<Request>.from(
            json["accepted_request"].map((x) => Request.fromJson(x))),
        rejectedRequest: List<Request>.from(
            json["rejected_request"].map((x) => Request.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tribal_request": tribalRequest?.map((e) => e.toJson()).toList(),
        "accepted_request": acceptedRequest?.map((x) => x.toJson()).toList(),
        "rejected_request": rejectedRequest?.map((x) => x.toJson()).toList(),
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
