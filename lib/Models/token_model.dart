// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
    Token({
        required this.idToken,
        required this.refreshToken,
        required this.expiresIn,
    });

    String idToken;
    String refreshToken;
    int expiresIn;

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        idToken: json["idToken"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
    );

    Map<String, dynamic> toJson() => {
        "idToken": idToken,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
    };
}
