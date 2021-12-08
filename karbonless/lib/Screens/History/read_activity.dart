// To parse this JSON data, do
//
//     final readActivity = readActivityFromJson(jsonString);

import 'dart:convert';

List<ReadActivity> readActivityFromJson(String str) => List<ReadActivity>.from(
    json.decode(str).map((x) => ReadActivity.fromJson(x)));

String readActivityToJson(List<ReadActivity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReadActivity {
  ReadActivity({
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
    this.quantity,
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
  int quantity;

  factory ReadActivity.fromJson(Map<String, dynamic> json) => ReadActivity(
        kredit: json["kredit"],
        id: json["_id"],
        type: json["type"],
        co2Emission: json["co2_emission"].toDouble(),
        mode: json["mode"] == null ? null : json["mode"],
        totalEmission: json["total_emission"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"],
        category: json["category"],
        owner: json["owner"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "kredit": kredit,
        "_id": id,
        "type": type,
        "co2_emission": co2Emission,
        "mode": mode == null ? null : mode,
        "total_emission": totalEmission,
        "distance": distance == null ? null : distance,
        "category": category,
        "owner": owner,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "quantity": quantity == null ? null : quantity,
      };
}
