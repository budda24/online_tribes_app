import 'dart:convert';

TribeDb tribeDbFromJson(String str) => TribeDb.fromJson(json.decode(str));

String tribeDbToJson(TribeDb data) => json.encode(data.toJson());

class TribeDb {
    TribeDb({
       required this.tribeId,
       required this.tribalName,
       required this.tribalSign,
       required this.tribalIntroVideo,
       required this.type,
       required this.description,
       required this.purpous,
       required this.goals,
       required this.mottoOfTribe,
       required this.weeklySuggestedTime,
        this.triberer,
    });

    String tribeId;
    String tribalName;
    String tribalSign;
    String tribalIntroVideo;
    String type;
    String description;
    String purpous;
    String goals;
    String mottoOfTribe;
    DateTime weeklySuggestedTime;
    List<Triberer>? triberer;

    factory TribeDb.fromJson(Map<String, dynamic> json) => TribeDb(
        tribeId: json["tribe_id"],
        tribalName: json["tribal_name"],
        tribalSign: json["tribal_sign"],
        tribalIntroVideo: json["tribal_intro_video"],
        type: json["type"],
        description: json["description"],
        purpous: json["purpous"],
        goals: json["goals"],
        mottoOfTribe: json["motto_of_tribe"],
        weeklySuggestedTime: DateTime.parse(json["weekly_suggested_time"]),
        triberer: List<Triberer>.from(json["triberer"].map((x) => Triberer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tribe_id": tribeId,
        "tribal_name": tribalName,
        "tribal_sign": tribalSign,
        "tribal_intro_video": tribalIntroVideo,
        "type": type,
        "description": description,
        "purpous": purpous,
        "goals": goals,
        "motto_of_tribe": mottoOfTribe,
        "weekly_suggested_time": weeklySuggestedTime.toIso8601String(),
        "triberer": triberer?.map((x) => x.toJson()).toList(),
    };
}

class Triberer {
    Triberer({
       required this.name,
       required this.profilePhoto,
       required this.motto,
       required this.role,
    });

    String name;
    String profilePhoto;
    String motto;
    String role;

    factory Triberer.fromJson(Map<String, dynamic> json) => Triberer(
        name: json["name"],
        profilePhoto: json["profile_photo"],
        motto: json["motto"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "profile_photo": profilePhoto,
        "motto": motto,
        "role": role,
    };
}
