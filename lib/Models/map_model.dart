// To parse this JSON data, do
//
//     final mapModel = mapModelFromJson(jsonString);

import 'dart:convert';

List<MapModel> mapModelFromJson(String str) =>
    List<MapModel>.from(json.decode(str).map((x) => MapModel.fromJson(x)));

String mapModelToJson(List<MapModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MapModel {
  int id;
  Addresses addresses;

  MapModel({
    required this.id,
    required this.addresses,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) => MapModel(
        id: json["id"],
        addresses: Addresses.fromJson(json["Addresses"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Addresses": addresses.toJson(),
      };
}

class Addresses {
  double latitude;
  double longitude;

  Addresses({
    required this.latitude,
    required this.longitude,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
