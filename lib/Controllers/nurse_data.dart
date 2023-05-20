import 'dart:convert';

import 'package:get/get.dart';
import '../Models/perawat_model.dart';
import 'package:http/http.dart' as http;

class NurseController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  //var str = ''.obs;
  var errmsg = "".obs;

  late Nurse singleNurse;

  Future<Nurse> getNurseDatabySTR(String str) async {
    isLoading(true);
    try {
      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/nurse/$str');

      final response = await http.get(url);
      final nurseData = json.decode(response.body)['data'];

      if (nurseData == null) {
        //print('data tidak ditemukan');
        isLoading(false);
        isError(true);
      }

      //final Map<String, dynamic> data = nurseData;

      //singleNurse = Nurse.fromJson(nurseData);

      await Future.delayed(const Duration(seconds: 2),
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
