import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';

import '../Models/user_model.dart';
import '../Models/storage_item.dart';

import '../services/api_service.dart';
import '../services/secure_storage.dart';
import '../services/simple_storage.dart';

class AuthController extends GetxController {
  final StorageService _storageService = StorageService();
  final SharedStorage sharedService = SharedStorage();
  final APIService _apiservice = APIService();

  final cloudinary = CloudinaryPublic('dtgwjo6bx', 'images00', cache: false);

  var isLogin = false.obs;
  var isToken = ''.obs;
  late User user;
  var strNumber = ''.obs;
  var isLoading = false.obs;

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

      var geturl = _apiservice.getURL("v1/api/auth/register");

      Uri url = Uri.parse(geturl);

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
      var geturl = _apiservice.getURL("v1/api/auth/login");

      Uri url = Uri.parse(geturl);

      //Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/auth/login');

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
      var geturl = _apiservice.getURL("v1/api/auth/$email/sendemail");

      Uri url = Uri.parse(geturl);

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
    isLoading(true);
    try {
      CloudinaryResponse cloudinaryresponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(file.path,
              resourceType: CloudinaryResourceType.Image));

      var geturl = _apiservice.getURL("v1/api/auth/upload");

      Uri url = Uri.parse(geturl);

      var token = await _storageService.readSecureData('token');

      final response = await http.put(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: json.encode({"image": cloudinaryresponse.secureUrl}));

      if (response.statusCode >= 400) {
        isLoading(false);
        return Get.snackbar(
          'Error',
          '',
          colorText: Colors.white,
          messageText: const Text(
            'Gagal mengganti layanan',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          backgroundColor: Colors.red.shade400,
          snackPosition: SnackPosition.TOP,
        );
      }

      var resbody = json.decode(response.body)['data'];

      user = User.fromJson(resbody);
      sharedService.addStringToSF(StorageItem('user', json.encode(resbody)));

      isLoading(false);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.snackbar(
          'Berhasil',
          '',
          colorText: Colors.white,
          messageText: const Text(
            'Gambar profil diganti',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          backgroundColor: Colors.green.shade400,
          snackPosition: SnackPosition.TOP,
        );
      }
    } on CloudinaryException catch (error) {
      return Get.snackbar(
        'Error',
        error.responseString,
        colorText: Colors.white,
        messageText: const Text(
          'Gagal menambah layanan',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        backgroundColor: Colors.red.shade400,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<bool> checkToken() async {
    isToken.value = await _storageService.readSecureData('token') ?? '';
    final userdata = await sharedService.getStringValuesSF('user');
    strNumber.value = await sharedService.getStringValuesSF('strNumber') ?? '';

    if (userdata != null && isToken.value != '') {
      var userJson = json.decode(userdata);
      user = User.fromJson(userJson);
      isLogin(true);
      return true;
    }

    return false;
  }

  logout() async {
    isLogin(false);
    await _storageService.deleteAllSecureData();
    await sharedService.deleteAll();
  }
}
