// To parse this JSON data, do
//
//     final travelFootprint = travelFootprintFromJson(jsonString);

import 'dart:convert';

TravelFootprint travelFootprintFromJson(String str) =>
    TravelFootprint.fromJson(json.decode(str));

String travelFootprintToJson(TravelFootprint data) =>
    json.encode(data.toJson());

class TravelFootprint {
  TravelFootprint({
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

  factory TravelFootprint.fromJson(Map<String, dynamic> json) =>
      TravelFootprint(
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

class InsertTravelValues {
  String mode;
  String vehicle;
  String vehicleType;
  int distance;
}
