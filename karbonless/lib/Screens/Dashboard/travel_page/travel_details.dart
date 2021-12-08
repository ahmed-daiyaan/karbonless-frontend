import 'dart:convert';

List<TravelDetails> travelDetailsFromJson(String str) =>
    List<TravelDetails>.from(
        json.decode(str).map((x) => TravelDetails.fromJson(x)));

String travelDetailsToJson(List<TravelDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TravelDetails {
  TravelDetails({
    this.type,
    this.co2Emission,
    this.mode,
  });

  String type;
  double co2Emission;
  String mode;

  factory TravelDetails.fromJson(Map<String, dynamic> json) => TravelDetails(
        type: json["type"],
        co2Emission: json["co2_emission"].toDouble(),
        mode: json["mode"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "co2_emission": co2Emission,
        "mode": mode,
      };
}
