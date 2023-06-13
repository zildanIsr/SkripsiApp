import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../services/secure_storage.dart';

class ReportController extends GetxController {
  final StorageService _storageService = StorageService();
  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = ''.obs;

  final descText = TextEditingController();

  sendReport(int reportedId, int orderId) async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');
      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/report/create');
      Map<String, dynamic> data = {
        "orderId": orderId,
        "perawatId": reportedId,
        "desciption": descText.text
      };

      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode(data),
      );

      if (response.statusCode >= 400 && response.statusCode < 500 ||
          response.statusCode >= 500) {
        Get.snackbar(
          'Error',
          '',
          colorText: Colors.white,
          messageText: const Text(
            'Gagal mengirim report',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          backgroundColor: Colors.red.shade400,
          snackPosition: SnackPosition.TOP,
        );
        isLoading(false);
        isError(true);
        return;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.snackbar(
          'Berhasil',
          '',
          colorText: Colors.white,
          messageText: const Text(
            'Report dikirim',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          backgroundColor: Colors.green.shade400,
          snackPosition: SnackPosition.TOP,
        );

        await Future.delayed(const Duration(seconds: 2));
        isLoading(false);
        isError(false);
      }
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }
}
