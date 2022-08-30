// To parse this JSON data, do
//
//     final tribalType = tribalTypeFromJson(jsonString);

// To parse this JSON data, do
//
//     final tribalType = tribalTypeFromJson(jsonString);

import 'dart:convert';

TribalType tribalTypeFromJson(String str) =>
    TribalType.fromJson(json.decode(str));

String tribalTypeToJson(TribalType data) => json.encode(data.toJson());

class TribalType {
  TribalType({
    required this.types,
  });

  List<String> types;

  factory TribalType.fromJson(Map<String, dynamic> json) => TribalType(
        types: List<String>.from(json["tribal_type"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tribal_type": List<dynamic>.from(types.map((x) => x)),
      };
}
