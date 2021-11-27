// To parse this JSON data, do
//
//     final foodFootprint = foodFootprintFromJson(jsonString);

import 'dart:convert';

FoodFootprint foodFootprintFromJson(String str) =>
    FoodFootprint.fromJson(json.decode(str));

String foodFootprintToJson(FoodFootprint data) => json.encode(data.toJson());

class FoodFootprint {
  FoodFootprint({
    this.kredit,
    this.id,
    this.type,
    this.co2Emission,
    this.totalEmission,
    this.quantity,
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
  double totalEmission;
  int quantity;
  String category;
  String owner;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory FoodFootprint.fromJson(Map<String, dynamic> json) => FoodFootprint(
        kredit: json["kredit"],
        id: json["_id"],
        type: json["type"],
        co2Emission: json["co2_emission"].toDouble(),
        totalEmission: json["total_emission"].toDouble(),
        quantity: json["quantity"],
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
        "total_emission": totalEmission,
        "quantity": quantity,
        "category": category,
        "owner": owner,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class InsertFoodValues {
  String food;
  int quantity;
}
