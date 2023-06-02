// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int id;
  String uniqueId;
  int price;
  int status;
  int categoryId;
  int perawatId;
  int userId;
  int orderedAmount;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  Category category;
  Perawat perawat;

  Product({
    required this.id,
    required this.uniqueId,
    required this.price,
    required this.status,
    required this.categoryId,
    required this.perawatId,
    required this.userId,
    required this.orderedAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.category,
    required this.perawat,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        uniqueId: json["UniqueID"],
        price: json["price"],
        status: json["status"],
        categoryId: json["categoryId"],
        perawatId: json["perawatId"],
        userId: json["userId"],
        orderedAmount: json["orderedAmount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: User.fromJson(json["User"]),
        category: Category.fromJson(json["Category"]),
        perawat: Perawat.fromJson(json["Perawat"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "UniqueID": uniqueId,
        "price": price,
        "status": status,
        "categoryId": categoryId,
        "perawatId": perawatId,
        "userId": userId,
        "orderedAmount": orderedAmount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "User": user.toJson(),
        "Category": category.toJson(),
        "Perawat": perawat.toJson(),
      };
}

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Perawat {
  int? id;
  String strNumber;
  double? rating;
  List<dynamic>? ratings;

  Perawat({
    required this.id,
    required this.strNumber,
    required this.rating,
    this.ratings,
  });

  factory Perawat.fromJson(Map<String, dynamic> json) => Perawat(
        id: json["id"],
        strNumber: json["strNumber"],
        rating: json["Rating"]?.toDouble(),
        ratings: json["Ratings"] == null
            ? []
            : List<dynamic>.from(json["Ratings"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "strNumber": strNumber,
        "Rating": rating,
        "Ratings":
            ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x)),
      };
}

class User {
  String name;
  String phoneNumber;
  dynamic image;

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
