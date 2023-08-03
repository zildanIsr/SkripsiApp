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
  String image;
  Nurse nurse;

  SearchModel({
    required this.name,
    required this.image,
    required this.nurse,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        name: json["name"],
        image: json["image"],
        nurse: Nurse.fromJson(json["Nurse"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "Nurse": nurse.toJson(),
      };
}

class Nurse {
  int id;
  String strNumber;

  Nurse({
    required this.id,
    required this.strNumber,
  });

  factory Nurse.fromJson(Map<String, dynamic> json) => Nurse(
        id: json["id"],
        strNumber: json["strNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "strNumber": strNumber,
      };
}
