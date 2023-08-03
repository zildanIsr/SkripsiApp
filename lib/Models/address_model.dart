// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(
    json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
  int? id;
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

  AddressModel({
    this.id,
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

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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
