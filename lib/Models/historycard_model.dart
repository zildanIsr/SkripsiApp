// To parse this JSON data, do
//
//     final historyCardModel = historyCardModelFromJson(jsonString);

import 'dart:convert';

List<HistoryCardModel> historyCardModelFromJson(String str) =>
    List<HistoryCardModel>.from(
        json.decode(str).map((x) => HistoryCardModel.fromJson(x)));

String historyCardModelToJson(List<HistoryCardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryCardModel {
  int id;
  String orderId;
  int productId;
  int nurseId;
  int userId;
  int uAddressId;
  int totprice;
  int status;
  bool isFinished;
  bool isRated;
  int pacientAmount;
  DateTime jadwalPesanan;
  DateTime createdAt;
  DateTime updatedAt;
  Product product;

  HistoryCardModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.nurseId,
    required this.userId,
    required this.uAddressId,
    required this.totprice,
    required this.status,
    required this.isFinished,
    required this.isRated,
    required this.pacientAmount,
    required this.jadwalPesanan,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory HistoryCardModel.fromJson(Map<String, dynamic> json) =>
      HistoryCardModel(
        id: json["id"],
        orderId: json["orderId"],
        productId: json["productId"],
        nurseId: json["nurseId"],
        userId: json["userId"],
        uAddressId: json["uAddressId"],
        totprice: json["totprice"],
        status: json["status"],
        isFinished: json["isFinished"],
        isRated: json["isRated"],
        pacientAmount: json["pacientAmount"],
        jadwalPesanan: DateTime.parse(json["jadwalPesanan"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        product: Product.fromJson(json["Product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "productId": productId,
        "nurseId": nurseId,
        "userId": userId,
        "uAddressId": uAddressId,
        "totprice": totprice,
        "status": status,
        "isFinished": isFinished,
        "isRated": isRated,
        "pacientAmount": pacientAmount,
        "jadwalPesanan": jadwalPesanan.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
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
