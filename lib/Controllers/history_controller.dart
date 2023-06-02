import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../Models/historycard_model.dart';
import '../Models/historydetail_model.dart';
import '../services/secure_storage.dart';
//import '../services/simple_storage.dart';

class HistoryContoller extends GetxController {
  final StorageService _storageService = StorageService();
  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = ''.obs;
  var rate = 3.0.obs;
  final descText = TextEditingController();

  var listHistory = <HistoryCardModel>[].obs;
  var listFinished = <HistoryCardModel>[].obs;

  late HistoryDetail detailhistory;

  @override
  void onInit() {
    getAllHistoryList();
    getAllHistoryFinished();
    super.onInit();
  }

  @override
  void onClose() {
    listHistory.close();
    listFinished.close();
    super.onClose();
  }

  Future<List<HistoryCardModel>> getAllHistoryList() async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');

      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/order/getorderbyUser');

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final resListFormat = json.decode(response.body)['data'];
      //print(resListFormat);
      final List data = resListFormat;

      await Future.delayed(
          const Duration(seconds: 2),
          () => {
                listHistory.value =
                    data.map((e) => HistoryCardModel.fromJson(e)).toList()
              });

      isLoading(false);
      isError(false);

      return listHistory;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  Future<List<HistoryCardModel>> getAllHistoryFinished() async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');

      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/order/getfinishedOrder');

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final resListFormat = json.decode(response.body)['data'];
      //print(resListFormat);
      final List data = resListFormat;

      await Future.delayed(
          const Duration(seconds: 2),
          () => {
                listFinished.value =
                    data.map((e) => HistoryCardModel.fromJson(e)).toList()
              });

      isLoading(false);
      isError(false);

      return listFinished;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  Future<HistoryDetail> getDetailHistory(int id) async {
    isLoading(true);
    try {
      //var token = await _storageService.readSecureData('token');

      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/order/detailOrder/$id');

      final response = await http.get(
        url,
      );
      final resListFormat = json.decode(response.body)['data'];
      //print(resListFormat);
      final data = resListFormat;

      //detailhistory = HistoryDetail.fromJson(data);
      await Future.delayed(const Duration(seconds: 3),
          () => {detailhistory = HistoryDetail.fromJson(data)});

      isLoading(false);
      isError(false);

      return detailhistory;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  acceptedOrder(int id, int status) async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');
      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/order/update/status/$id');
      Map<String, dynamic> data = {"status": status};

      final response = await http.patch(
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
            'Konfirmasi Gagal',
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
        await refreshData();

        Get.snackbar(
          'Berhasil',
          '',
          colorText: Colors.white,
          messageText: const Text(
            'Konfirmasi Berhasil',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          backgroundColor: Colors.green.shade400,
          snackPosition: SnackPosition.TOP,
        );

        await Future.delayed(const Duration(seconds: 2));
        isLoading(false);
        isError(false);
        Get.back();
      }
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  orderFinished(int id) async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');
      Uri url = Uri.parse(
          'http://192.168.100.4:3500/v1/api/order/update/finished/$id');

      final response = await http.patch(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode >= 400 && response.statusCode < 500 ||
          response.statusCode >= 500) {
        Get.snackbar(
          'Error',
          '',
          colorText: Colors.white,
          messageText: const Text(
            'Konfirmasi Gagal',
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
        await refreshData();

        Get.snackbar(
          'Berhasil',
          '',
          colorText: Colors.white,
          messageText: const Text(
            'Pesanan Selesai',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          backgroundColor: Colors.green.shade400,
          snackPosition: SnackPosition.TOP,
        );

        await Future.delayed(const Duration(seconds: 1));
        isLoading(false);
        isError(false);
        Get.back();
      }
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  sendRating(int nurseId, int orderId) async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');
      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/rating/create');
      Map<String, dynamic> data = {
        "orderId": orderId,
        "perawatId": nurseId,
        "rate": rate.value,
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
            'Gagal mengirim rating',
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
        await refreshData();

        Get.snackbar(
          'Berhasil',
          '',
          colorText: Colors.white,
          messageText: const Text(
            'Rating Berhasil',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          backgroundColor: Colors.green.shade400,
          snackPosition: SnackPosition.TOP,
        );

        await Future.delayed(const Duration(seconds: 2));
        isLoading(false);
        isError(false);
        Get.back();
      }
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  Future<void> refreshData() async {
    try {
      listHistory.clear();
      listFinished.clear();
      await getAllHistoryList();
      await getAllHistoryFinished();
    } catch (e) {
      throw Exception(e);
    }
  }
}
