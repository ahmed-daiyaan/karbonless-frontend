// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'dart:convert';

List<ProductDetails> productDetailsFromJson(String str) =>
    List<ProductDetails>.from(
        json.decode(str).map((x) => ProductDetails.fromJson(x)));

String productDetailsToJson(List<ProductDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDetails {
  ProductDetails({
    this.name,
    this.score,
  });

  String name;
  double score;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        name: json["name"],
        score: json["score"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "score": score,
      };
}

// To parse this JSON data, do
//
//     final productFootprint = productFootprintFromJson(jsonString);

ProductFootprint productFootprintFromJson(String str) =>
    ProductFootprint.fromJson(json.decode(str));

String productFootprintToJson(ProductFootprint data) =>
    json.encode(data.toJson());

class ProductFootprint {
  ProductFootprint({
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

  factory ProductFootprint.fromJson(Map<String, dynamic> json) =>
      ProductFootprint(
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
// To parse this JSON data, do
//
//     final allProducts = allProductsFromJson(jsonString);

List<AllProducts> allProductsFromJson(String str) => List<AllProducts>.from(
    json.decode(str).map((x) => AllProducts.fromJson(x)));

String allProductsToJson(List<AllProducts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllProducts {
  AllProducts({
    this.type,
    this.co2Emission,
  });

  String type;
  double co2Emission;

  factory AllProducts.fromJson(Map<String, dynamic> json) => AllProducts(
        type: json["type"],
        co2Emission: json["co2_emission"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "co2_emission": co2Emission,
      };
}
