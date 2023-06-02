// To parse this JSON data, do
//
//     final ratingDetail = ratingDetailFromJson(jsonString);

import 'dart:convert';

List<RatingDetail> ratingDetailFromJson(String str) => List<RatingDetail>.from(
    json.decode(str).map((x) => RatingDetail.fromJson(x)));

String ratingDetailToJson(List<RatingDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RatingDetail {
  int id;
  int orderId;
  int userId;
  int perawatId;
  int rate;
  String desciption;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  Order order;

  RatingDetail({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.perawatId,
    required this.rate,
    required this.desciption,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.order,
  });

  factory RatingDetail.fromJson(Map<String, dynamic> json) => RatingDetail(
        id: json["id"],
        orderId: json["orderId"],
        userId: json["userId"],
        perawatId: json["perawatId"],
        rate: json["rate"],
        desciption: json["desciption"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: User.fromJson(json["User"]),
        order: Order.fromJson(json["Order"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "userId": userId,
        "perawatId": perawatId,
        "rate": rate,
        "desciption": desciption,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "User": user.toJson(),
        "Order": order.toJson(),
      };
}

class Order {
  int productId;
  Product product;

  Order({
    required this.productId,
    required this.product,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        productId: json["productId"],
        product: Product.fromJson(json["Product"]),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "Product": product.toJson(),
      };
}

class Product {
  int categoryId;

  Product({
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
      };
}

class User {
  String name;
  dynamic image;

  User({
    required this.name,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
      };
}
