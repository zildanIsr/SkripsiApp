// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) =>
    UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  int? id;
  String name;
  String email;
  String? birthDate;
  int? sex;
  String phoneNumber;
  String? image;
  int roleId;
  String? height;
  String? weight;
  DateTime createdAt;
  DateTime updatedAt;
  List<Order> orders;

  UserDetail({
    this.id,
    required this.name,
    required this.email,
    this.birthDate,
    this.sex,
    required this.phoneNumber,
    this.image,
    required this.roleId,
    this.height,
    this.weight,
    required this.createdAt,
    required this.updatedAt,
    required this.orders,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        birthDate: json["birthDate"],
        sex: json["sex"],
        phoneNumber: json["phoneNumber"],
        image: json["image"],
        roleId: json["roleId"],
        height: json["height"],
        weight: json["weight"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        orders: List<Order>.from(json["Orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "birthDate": birthDate,
        "sex": sex,
        "phoneNumber": phoneNumber,
        "image": image,
        "roleId": roleId,
        "height": height,
        "weight": weight,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  String orderId;

  Order({
    required this.orderId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
      };
}
