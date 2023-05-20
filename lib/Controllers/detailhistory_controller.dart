import 'dart:convert';

import 'package:get/get.dart';

import '../Models/historydetail_model.dart';
import 'package:http/http.dart' as http;

class HistoryDetailController extends GetxController {
  //final StorageService _storageService = StorageService();
  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = ''.obs;

  late HistoryDetail detailhistory;

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
}
