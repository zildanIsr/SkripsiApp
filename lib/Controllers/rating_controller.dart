import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../Models/testimoni_model.dart';
//import '../services/secure_storage.dart';
//import '../services/simple_storage.dart';

class RatingController extends GetxController {
  //final StorageService _storageService = StorageService();
  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = ''.obs;

  var listTestimoni = <RatingDetail>[].obs;
  var rating = 0.0.obs;
  var totOrder = 0.obs;

  @override
  void onClose() {
    isLoading.close();
    isError.close();
    listTestimoni.close();
    errmsg.close();
    rating.close();
    totOrder.close();
    super.onClose();
  }

  Future<List<RatingDetail>> getAllTestimoni(int id, int? rateValue) async {
    isLoading(true);
    try {
      var url = 'http://192.168.100.4:3500/v1/api/rating/$id/getRatingsbyNurse';

      if (rateValue != null) {
        url += '?rateValue=$rateValue';
      }

      Uri newurl = Uri.parse(url);

      final response = await http.get(
        newurl,
      );
      final resListFormat = json.decode(response.body)['data'];
      var rate = json.decode(response.body)['rating'];

      rating.value = rate.toDouble();
      totOrder.value = json.decode(response.body)['orderDone'];

      if (resListFormat == null) {
        //print('tidak ada data');
        isLoading(false);
        isError(true);
      }

      final List data = resListFormat;

      await Future.delayed(
          const Duration(seconds: 2),
          () => {
                listTestimoni.value =
                    data.map((e) => RatingDetail.fromJson(e)).toList()
              });

      isLoading(false);
      isError(false);

      return listTestimoni;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }
}
