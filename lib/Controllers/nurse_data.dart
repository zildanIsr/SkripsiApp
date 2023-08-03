import 'dart:convert';

import 'package:get/get.dart';
import '../Models/perawat_model.dart';
import 'package:http/http.dart' as http;

import '../services/api_service.dart';

class NurseController extends GetxController {
  final APIService _apiservice = APIService();

  var isLoading = true.obs;
  var isError = false.obs;
  //var str = ''.obs;
  var errmsg = "".obs;
  var rating = 0.0.obs;

  late Nurse singleNurse;

  Future<Nurse> getNurseDatabySTR(String str) async {
    isLoading(true);
    try {
      var geturl = _apiservice.getURL("v1/api/nurse/$str");

      Uri url = Uri.parse(geturl);

      //Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/nurse/$str');

      final response = await http.get(url);
      final nurseData = json.decode(response.body)['data'];
      var rate = json.decode(response.body)['rating'] ?? 0.0;

      rating.value = rate.toDouble();

      if (nurseData == null) {
        //print('data tidak ditemukan');
        isLoading(false);
        isError(true);
      }

      await Future.delayed(const Duration(seconds: 3),
          () => {singleNurse = Nurse.fromJson(nurseData)});

      isLoading(false);
      isError(false);

      return singleNurse;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }
}
