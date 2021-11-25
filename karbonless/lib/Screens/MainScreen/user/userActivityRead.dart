// To parse this JSON data, do
//
//     final userActivity = userActivityFromJson(jsonString);

import 'dart:convert';

List<UserActivity> userActivityFromJson(String str) => List<UserActivity>.from(
    json.decode(str).map((x) => UserActivity.fromJson(x)));

String userActivityToJson(List<UserActivity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserActivity {
  UserActivity({
    this.kredit,
    this.id,
    this.type,
    this.co2Emission,
    this.mode,
    this.totalEmission,
    this.distance,
    this.category,
    this.owner,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  int kredit;
  String id;
  Type type;
  double co2Emission;
  Mode mode;
  double totalEmission;
  int distance;
  Category category;
  Owner owner;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory UserActivity.fromJson(Map<String, dynamic> json) => UserActivity(
        kredit: json["kredit"],
        id: json["_id"],
        type: typeValues.map[json["type"]],
        co2Emission: json["co2_emission"].toDouble(),
        mode: modeValues.map[json["mode"]],
        totalEmission: json["total_emission"].toDouble(),
        distance: json["distance"],
        category: categoryValues.map[json["category"]],
        owner: ownerValues.map[json["owner"]],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "kredit": kredit,
        "_id": id,
        "type": typeValues.reverse[type],
        "co2_emission": co2Emission,
        "mode": modeValues.reverse[mode],
        "total_emission": totalEmission,
        "distance": distance,
        "category": categoryValues.reverse[category],
        "owner": ownerValues.reverse[owner],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

enum Category { TRAVEL }

final categoryValues = EnumValues({"Travel": Category.TRAVEL});

enum Mode { LAND }

final modeValues = EnumValues({"Land": Mode.LAND});

enum Owner { THE_6193_F8510_EFD4100168_D33_F6 }

final ownerValues = EnumValues(
    {"6193f8510efd4100168d33f6": Owner.THE_6193_F8510_EFD4100168_D33_F6});

enum Type { TWO_WHEELERS_SCOOTER }

final typeValues =
    EnumValues({"Two Wheelers, Scooter": Type.TWO_WHEELERS_SCOOTER});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
