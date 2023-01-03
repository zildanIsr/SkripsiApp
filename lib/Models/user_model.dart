// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);


import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.localId,
        required this.email,
        required this.displayName,
        required this.idToken,
        this.registered = true,
        required this.refreshToken,
        required this.expiresIn,
    });

    String localId;
    String email;
    String displayName;
    String idToken;
    bool registered;
    String refreshToken;
    String expiresIn;

    factory User.fromJson(Map<String, dynamic> json) => User(
        localId: json["localId"],
        email: json["email"],
        displayName: json["displayName"],
        idToken: json["idToken"],
        registered: json["registered"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
    );

    Map<String, dynamic> toJson() => {
        "localId": localId,
        "email": email,
        "displayName": displayName,
        "idToken": idToken,
        "registered": registered,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
    };
}
