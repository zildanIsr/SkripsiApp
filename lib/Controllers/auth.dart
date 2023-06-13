import 'dart:convert';
import 'dart:io';

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

  signUpAuth(
      String? email, String? password, Map<String, String>? addtional) async {
    try {
      var itemList = addtional!.values.toList();
      //print('${itemList[0]}, ${itemList[1]}');

      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/auth/register');

      //print('Name: $email, Password: $password');

      final response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode({
            "email": email,
            "password": password,
            "name": itemList[0],
            "phoneNumber": itemList[1]
          }));

      if (response.statusCode >= 400) {
        return response.statusCode;
      }

      var resbody = json.decode(response.body)['data'];
      var token = json.decode(response.body)['token'];
      _storageService.writeSecureData(StorageItem('token', token));
      sharedService.addStringToSF(StorageItem('user', json.encode(resbody)));

      user = User.fromJson(resbody);

      return response.statusCode;
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

      user = User.fromJson(resbody);
      //print('str:  ${nurse['strNumber']}');
      if (nurse != null) {
        strNumber.value = nurse['strNumber'] ?? '';
        sharedService.addStringToSF(StorageItem('strNumber', strNumber.value));
      }

      // sharedService.addStringToSF(StorageItem('user_name', user.name));
      // sharedService.addIntToSF(StorageItem('role', user.roleId));
      // sharedService.addIntToSF(StorageItem('userId', user.id));

      return response.statusCode;
    } catch (e) {
      rethrow;
    }
  }

  forgetPassword(String email) async {
    try {
      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/auth/$email/sendemail');

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      return response.statusCode;
    } catch (e) {
      throw Exception(e);
    }
  }

  uploadImage(File file) async {
    try {
      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/auth/upload');

      var token = await _storageService.readSecureData('token');

      Map<String, String> headers = <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var request = http.MultipartRequest('POST', url);

      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath('image', file.path));

      var response = await request.send();

      if (response.statusCode >= 400) {
        return response.statusCode;
      }

      // var resbody = json.decode(response.body)['data'];

      // ac.user = User.fromJson(resbody);
      // sharedService.addStringToSF(StorageItem('user', json.encode(resbody)));

      return response.statusCode;
    } catch (error) {
      throw Exception(error);
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
