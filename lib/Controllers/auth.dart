import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/user_model.dart';
import '../Models/storage_item.dart';

import '../services/secure_storage.dart';
import '../services/simple_storage.dart';

class AuthController extends GetxController {
  final StorageService _storageService = StorageService();
  final SharedStorage sharedService = SharedStorage();

  var isLogin = false.obs;
  String? isToken;
  late User user;
  var strNumber = ''.obs;

  @override
  void onInit() {
    checkToken();
    super.onInit();
  }

  void signUpAuth(String? email, String? password) async {
    try {
      Uri url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyC1vKoR-lrVBYZSD_NwApo1NNqNX-iEX7s');

      await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
    } catch (e) {
      rethrow;
    }
  }

  signInAuth(String email, String password) async {
    try {
      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/auth/login');

      //print('Name: $email, Password: $password');

      final response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode({"email": email, "password": password}));

      if (response.statusCode >= 400) {
        return response.statusCode;
      }

      var resbody = json.decode(response.body)['data'];
      var token = json.decode(response.body)['token'];
      var nurse = json.decode(response.body)['nurse'];
      _storageService.writeSecureData(StorageItem('token', token));
      sharedService.addStringToSF(StorageItem('user', json.encode(resbody)));
      sharedService.addStringToSF(StorageItem('strNumber', json.encode(nurse)));

      user = User.fromJson(resbody);
      //print('str:  ${nurse['strNumber']}');
      strNumber.value = nurse['strNumber'];

      // sharedService.addStringToSF(StorageItem('user_name', user.name));
      // sharedService.addIntToSF(StorageItem('role', user.roleId));
      // sharedService.addIntToSF(StorageItem('userId', user.id));

      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  Future<bool> checkToken() async {
    isToken = await _storageService.readSecureData('token');
    final userdata = await sharedService.getStringValuesSF('user');
    strNumber.value = await sharedService.getStringValuesSF('strNumber') ?? '';

    if (userdata == null && isToken == null) {
      isLogin(false);
      return false;
    }

    var userJson = json.decode(userdata!);
    user = User.fromJson(userJson);
    isLogin(true);

    return true;
  }

  logout() async {
    isLogin(false);
    await _storageService.deleteAllSecureData();
    await sharedService.deleteAll();
  }
}
