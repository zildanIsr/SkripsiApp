// To parse this JSON data, do
//
//     final nurse = nurseFromJson(jsonString);

import 'dart:convert';

Nurse nurseFromJson(String str) => Nurse.fromJson(json.decode(str));

String nurseToJson(Nurse data) => json.encode(data.toJson());

class Nurse {
  int? id;
  String workPlace;
  String strNumber;
  List<String> education;
  String workTime;
  String? rating;
  List<String> timeRange;
  List<String> dayActive;
  int? userId;
  DateTime createdAt;
  DateTime updatedAt;
  User? user;
  List<Product>? products;
  List<Order>? orders;

  Nurse({
    this.id,
    required this.workPlace,
    required this.strNumber,
    required this.education,
    required this.workTime,
    this.rating,
    required this.timeRange,
    required this.dayActive,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.products,
    this.orders,
  });

  factory Nurse.fromJson(Map<String, dynamic> json) => Nurse(
        id: json["id"],
        workPlace: json["workPlace"],
        strNumber: json["strNumber"],
        education: List<String>.from(json["education"].map((x) => x)),
        workTime: json["workTime"],
        rating: json["rating"],
        timeRange: List<String>.from(json["timeRange"].map((x) => x)),
        dayActive: List<String>.from(json["dayActive"].map((x) => x)),
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: User.fromJson(json["User"]),
        products: List<Product>.from(
            json["Products"].map((x) => Product.fromJson(x))),
        orders: List<Order>.from(json["Orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workPlace": workPlace,
        "strNumber": strNumber,
        "education": List<dynamic>.from(education.map((x) => x)),
        "workTime": workTime,
        "rating": rating,
        "timeRange": List<dynamic>.from(timeRange.map((x) => x)),
        "dayActive": List<dynamic>.from(dayActive.map((x) => x)),
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
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

class Product {
  String uniqueId;

  Product({
    required this.uniqueId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        uniqueId: json["UniqueID"],
      );

  Map<String, dynamic> toJson() => {
        "UniqueID": uniqueId,
      };
}

class User {
  String name;
  String phoneNumber;
  String? image;

  User({
    required this.name,
    required this.phoneNumber,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "image": image,
      };
}
