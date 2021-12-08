// To parse this JSON data, do
//
//     final foodDetails = foodDetailsFromJson(jsonString);

import 'dart:convert';

List<FoodDetails> foodDetailsFromJson(String str) => List<FoodDetails>.from(
    json.decode(str).map((x) => FoodDetails.fromJson(x)));

String foodDetailsToJson(List<FoodDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodDetails {
  FoodDetails({
    this.type,
    this.co2Emission,
  });

  String type;
  double co2Emission;

  factory FoodDetails.fromJson(Map<String, dynamic> json) => FoodDetails(
        type: json["type"],
        co2Emission: json["co2_emission"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "co2_emission": co2Emission,
      };
}
