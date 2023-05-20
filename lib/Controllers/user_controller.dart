import 'dart:convert';

import 'package:get/get.dart';
import '../Models/storage_item.dart';
import '../Models/userDetail_model.dart';
import '../Models/user_model.dart';

import 'package:http/http.dart' as http;
import '../services/secure_storage.dart';
import '../services/simple_storage.dart';
import 'auth.dart';

class UserController extends GetxController {
  final StorageService _storageService = StorageService();
  final SharedStorage sharedService = SharedStorage();
  AuthController ac = Get.put(AuthController());

  var isLoading = false.obs;
  var isError = false.obs;
  var errmsg = ''.obs;
  var userRole = 1.obs;
  var address = ''.obs;

  late User userdata;
  late UserDetail userbyid;

  @override
  void onInit() {
    //getDataUser();
    //getRole();
    super.onInit();
  }

  getRole() async {
    var getuserRole = await sharedService.getIntValuesSF('role');
    userRole(getuserRole);
  }

  getaddress() async {
    var getuserAddress =
        await sharedService.getStringValuesSF('stringAddress') ?? '-';
    address(getuserAddress);
  }

  Future<User> getDataUser() async {
    isLoading(true);
    try {
      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/auth/getUser');

      var token = await _storageService.readSecureData('token');

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final data = json.decode(response.body)['data'];

      if (data == null) {
        //print('data tidak ditemukan');
        isLoading(false);
        isError(true);
      }

      //final Map<String, dynamic> data = nurseData;

      //singleNurse = Nurse.fromJson(nurseData);
      userdata = User.fromJson(data);
      // await Future.delayed(
      //     const Duration(seconds: 2), () => {userdata = User.fromJson(data)});

      isLoading(false);
      isError(false);

      return userdata;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  Future<UserDetail> getDataUserbyId(int id) async {
    isLoading(true);
    try {
      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/auth/$id/getUser');

      final response = await http.get(
        url,
      );
      final data = json.decode(response.body)['data'];

      if (data == null) {
        //print('data tidak ditemukan');
        isLoading(false);
        isError(true);
      }

      //final Map<String, dynamic> data = nurseData;

      //singleNurse = Nurse.fromJson(nurseData);
      getaddress();

      await Future.delayed(const Duration(seconds: 1),
          () => {userbyid = UserDetail.fromJson(data)});

      isLoading(false);
      isError(false);

      return userbyid;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  onUpdatedata(User user) async {
    isLoading(true);
    try {
      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/auth/update');

      var token = await _storageService.readSecureData('token');

      final response = await http.put(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: json.encode(user));

      if (response.statusCode >= 400) {
        return response.statusCode;
      }

      var resbody = json.decode(response.body)['data'];

      ac.user = User.fromJson(resbody);
      sharedService.addStringToSF(StorageItem('user', json.encode(resbody)));

      Future.delayed(
          const Duration(seconds: 5), () => {isLoading(false), isError(false)});

      return response.statusCode;
    } catch (error) {
      isLoading(false);
      isError(true);
      errmsg(error.toString());
      throw Exception(error);
    }
  }
}
