// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(
    json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  String name;
  dynamic image;
  Perawat perawat;

  SearchModel({
    required this.name,
    required this.image,
    required this.perawat,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        name: json["name"],
        image: json["image"],
        perawat: Perawat.fromJson(json["Perawat"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "Perawat": perawat.toJson(),
      };
}

class Perawat {
  int id;
  String strNumber;

  Perawat({
    required this.id,
    required this.strNumber,
  });

  factory Perawat.fromJson(Map<String, dynamic> json) => Perawat(
        id: json["id"],
        strNumber: json["strNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "strNumber": strNumber,
      };
}
