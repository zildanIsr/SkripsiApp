import 'dart:convert';

import 'package:get/get.dart';

import '../Models/costumerorder_model.dart';
import '../services/secure_storage.dart';
import 'package:http/http.dart' as http;

class OrderConfirm extends GetxController {
  final StorageService _storageService = StorageService();
  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = "".obs;

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      isLoading(false);
    });
    super.onInit();
  }

  void updateLoading(bool load) {
    isLoading(load);
  }

  addNewOrder(Order data) async {
    isLoading(true);
    try {
      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/order/create');

      var token = await _storageService.readSecureData('token');

      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode(data));

      Future.delayed(
          const Duration(seconds: 2), () => {isLoading(false), isError(false)});

      return response.statusCode;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  Future<void> onSubmit() async {
    return await Future.delayed(
        const Duration(seconds: 5), () => isLoading.value = false);
  }
}
