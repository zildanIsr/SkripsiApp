// To parse this JSON data, do
//
//     final nearbyLocation = nearbyLocationFromJson(jsonString);

import 'dart:convert';

List<NearbyLocation> nearbyLocationFromJson(String str) =>
    List<NearbyLocation>.from(
        json.decode(str).map((x) => NearbyLocation.fromJson(x)));

String nearbyLocationToJson(List<NearbyLocation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NearbyLocation {
  String businessStatus;
  Geometry geometry;
  String icon;
  String iconBackgroundColor;
  String iconMaskBaseUri;
  String name;
  OpeningHours openingHours;
  String placeId;
  int rating;
  String reference;
  String scope;
  List<String> types;
  int userRatingsTotal;
  String vicinity;
  List<Photo>? photos;
  PlusCode? plusCode;

  NearbyLocation({
    required this.businessStatus,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.openingHours,
    required this.placeId,
    required this.rating,
    required this.reference,
    required this.scope,
    required this.types,
    required this.userRatingsTotal,
    required this.vicinity,
    this.photos,
    this.plusCode,
  });

  factory NearbyLocation.fromJson(Map<String, dynamic> json) => NearbyLocation(
        businessStatus: json["business_status"],
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        openingHours: OpeningHours.fromJson(json["opening_hours"]),
        placeId: json["place_id"],
        rating: json["rating"],
        reference: json["reference"],
        scope: json["scope"],
        types: List<String>.from(json["types"].map((x) => x)),
        userRatingsTotal: json["user_ratings_total"],
        vicinity: json["vicinity"],
        photos: json["photos"] == null
            ? []
            : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
        plusCode: json["plus_code"] == null
            ? null
            : PlusCode.fromJson(json["plus_code"]),
      );

  Map<String, dynamic> toJson() => {
        "business_status": businessStatus,
        "geometry": geometry.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "opening_hours": openingHours.toJson(),
        "place_id": placeId,
        "rating": rating,
        "reference": reference,
        "scope": scope,
        "types": List<dynamic>.from(types.map((x) => x)),
        "user_ratings_total": userRatingsTotal,
        "vicinity": vicinity,
        "photos": photos == null
            ? []
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "plus_code": plusCode?.toJson(),
      };
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}

class OpeningHours {
  bool openNow;

  OpeningHours({
    required this.openNow,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
      };
}

class Photo {
  double height;
  List<String> htmlAttributions;
  String photoReference;
  double width;

  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"]?.toDouble(),
        htmlAttributions:
            List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}
