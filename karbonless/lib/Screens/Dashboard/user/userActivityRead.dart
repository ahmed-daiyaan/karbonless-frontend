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
  String type;
  double co2Emission;
  String mode;
  double totalEmission;
  int distance;
  String category;
  String owner;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory UserActivity.fromJson(Map<String, dynamic> json) => UserActivity(
        kredit: json["kredit"],
        id: json["_id"],
        type: json["type"],
        co2Emission: json["co2_emission"].toDouble(),
        mode: json["mode"],
        totalEmission: json["total_emission"].toDouble(),
        distance: json["distance"],
        category: json["category"],
        owner: json["owner"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "kredit": kredit,
        "_id": id,
        "type": type,
        "co2_emission": co2Emission,
        "mode": mode,
        "total_emission": totalEmission,
        "distance": distance,
        "category": category,
        "owner": owner,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
