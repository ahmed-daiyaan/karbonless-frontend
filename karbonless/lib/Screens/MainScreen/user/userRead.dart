// To parse this JSON data, do
//
//     final userRead = userReadFromJson(jsonString);

import 'dart:convert';

UserRead userReadFromJson(String str) => UserRead.fromJson(json.decode(str));

String userReadToJson(UserRead data) => json.encode(data.toJson());

class UserRead {
  UserRead({
    this.age,
    this.kredit,
    this.rank,
    this.streak,
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  int age;
  int kredit;
  int rank;
  int streak;
  String id;
  String name;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory UserRead.fromJson(Map<String, dynamic> json) => UserRead(
        age: json["age"],
        kredit: json["kredit"],
        rank: json["rank"],
        streak: json["streak"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "kredit": kredit,
        "rank": rank,
        "streak": streak,
        "_id": id,
        "name": name,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
