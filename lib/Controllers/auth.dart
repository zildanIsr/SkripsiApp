import 'dart:convert';

import 'package:flutter_application_1/Controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController{
  var userController = Get.put(UserController());

  void signUpAuth (String? email, String? password) async {
    try {
      Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyC1vKoR-lrVBYZSD_NwApo1NNqNX-iEX7s');
      
      await http.post(url, 
        body: json.encode({
            "email" : email,
            "password" : password,
            "returnSecureToken": true,
          })
      );
    } catch (e) {
      rethrow;
    }
  }

  signInAuth (String? email, String? password) async {
    try {
      Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC1vKoR-lrVBYZSD_NwApo1NNqNX-iEX7s'
      );

      var responses = await http.post(url, 
        body: json.encode({
            "email" : email,
            "password" : password,
            "returnSecureToken": true,
          })
      );

      var res = json.decode(responses.body);
      userController.getUser(res);

      return res;
    } catch (e) {
      rethrow;
    }
  }
}