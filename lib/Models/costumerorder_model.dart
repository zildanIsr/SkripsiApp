// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  int? id;
  String orderId;
  int productId;
  int? perawatId;
  int? userId;
  int? uAddressId;
  int totprice;
  int pacientAmount;
  DateTime jadwalPesanan;
  DateTime? updatedAt;
  DateTime? createdAt;

  Order({
    this.id,
    required this.orderId,
    required this.productId,
    this.perawatId,
    this.userId,
    this.uAddressId,
    required this.totprice,
    required this.pacientAmount,
    required this.jadwalPesanan,
    this.updatedAt,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderId: json["orderId"],
        productId: json["productId"],
        perawatId: json["perawatId"],
        userId: json["userId"],
        uAddressId: json["uAddressId"],
        totprice: json["totprice"],
        pacientAmount: json["pacientAmount"],
        jadwalPesanan: DateTime.parse(json["jadwalPesanan"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "productId": productId,
        "perawatId": perawatId,
        "userId": userId,
        "uAddressId": uAddressId,
        "totprice": totprice,
        "pacientAmount": pacientAmount,
        "jadwalPesanan": jadwalPesanan.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
