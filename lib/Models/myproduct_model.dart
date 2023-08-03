// To parse this JSON data, do
//
//     final myProduct = myProductFromJson(jsonString);

import 'dart:convert';

List<MyProduct> myProductFromJson(String str) =>
    List<MyProduct>.from(json.decode(str).map((x) => MyProduct.fromJson(x)));

String myProductToJson(List<MyProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyProduct {
  int id;
  String uniqueId;
  int price;
  int status;
  int categoryId;
  int nurseId;
  int userId;
  int orderedAmount;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  Category category;
  Nurse nurse;

  MyProduct({
    required this.id,
    required this.uniqueId,
    required this.price,
    required this.status,
    required this.categoryId,
    required this.nurseId,
    required this.userId,
    required this.orderedAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.category,
    required this.nurse,
  });

  factory MyProduct.fromJson(Map<String, dynamic> json) => MyProduct(
        id: json["id"],
        uniqueId: json["UniqueID"],
        price: json["price"],
        status: json["status"],
        categoryId: json["categoryId"],
        nurseId: json["nurseId"],
        userId: json["userId"],
        orderedAmount: json["orderedAmount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: User.fromJson(json["User"]),
        category: Category.fromJson(json["Category"]),
        nurse: Nurse.fromJson(json["Nurse"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "UniqueID": uniqueId,
        "price": price,
        "status": status,
        "categoryId": categoryId,
        "nurseId": nurseId,
        "userId": userId,
        "orderedAmount": orderedAmount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "User": user.toJson(),
        "Category": category.toJson(),
        "Nurse": nurse.toJson(),
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

class Nurse {
  String strNumber;

  Nurse({
    required this.strNumber,
  });

  factory Nurse.fromJson(Map<String, dynamic> json) => Nurse(
        strNumber: json["strNumber"],
      );

  Map<String, dynamic> toJson() => {
        "strNumber": strNumber,
      };
}

class User {
  String name;
  String phoneNumber;
  String image;

  User({
    required this.name,
    required this.phoneNumber,
    required this.image,
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
