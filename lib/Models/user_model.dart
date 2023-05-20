// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String name;
  String? email;
  dynamic birthDate;
  dynamic sex;
  String phoneNumber;
  dynamic image;
  dynamic height;
  dynamic weight;
  int? roleId;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    this.id,
    required this.name,
    this.email,
    this.birthDate,
    this.sex,
    required this.phoneNumber,
    this.image,
    this.height,
    this.weight,
    this.roleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        birthDate: json["birthDate"],
        sex: json["sex"],
        phoneNumber: json["phoneNumber"],
        image: json["image"],
        height: json["height"],
        weight: json["weight"],
        roleId: json["roleId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "birthDate": birthDate,
        "sex": sex,
        "phoneNumber": phoneNumber,
        "image": image,
        "height": height,
        "weight": weight,
        "roleId": roleId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
