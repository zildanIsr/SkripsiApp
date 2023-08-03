// To parse this JSON data, do
//
//     final historyDetail = historyDetailFromJson(jsonString);

import 'dart:convert';

HistoryDetail historyDetailFromJson(String str) =>
    HistoryDetail.fromJson(json.decode(str));

String historyDetailToJson(HistoryDetail data) => json.encode(data.toJson());

class HistoryDetail {
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
  Nurse nurse;
  User user;
  Address address;

  HistoryDetail({
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
    required this.nurse,
    required this.user,
    required this.address,
  });

  factory HistoryDetail.fromJson(Map<String, dynamic> json) => HistoryDetail(
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
        nurse: Nurse.fromJson(json["Nurse"]),
        user: User.fromJson(json["User"]),
        address: Address.fromJson(json["Address"]),
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
        "Nurse": nurse.toJson(),
        "User": user.toJson(),
        "Address": address.toJson(),
      };
}

class Address {
  int id;
  String street;
  String sublocality;
  String locality;
  String subadminisArea;
  String adminisArea;
  String postalCode;
  String country;
  double latitude;
  double longitude;
  bool status;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  Address({
    required this.id,
    required this.street,
    required this.sublocality,
    required this.locality,
    required this.subadminisArea,
    required this.adminisArea,
    required this.postalCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        street: json["street"],
        sublocality: json["sublocality"],
        locality: json["locality"],
        subadminisArea: json["subadminisArea"],
        adminisArea: json["adminisArea"],
        postalCode: json["postalCode"],
        country: json["country"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        status: json["status"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "street": street,
        "sublocality": sublocality,
        "locality": locality,
        "subadminisArea": subadminisArea,
        "adminisArea": adminisArea,
        "postalCode": postalCode,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Nurse {
  String strNumber;
  User user;

  Nurse({
    required this.strNumber,
    required this.user,
  });

  factory Nurse.fromJson(Map<String, dynamic> json) => Nurse(
        strNumber: json["strNumber"],
        user: User.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "strNumber": strNumber,
        "User": user.toJson(),
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
