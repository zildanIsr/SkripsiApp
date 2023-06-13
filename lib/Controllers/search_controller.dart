import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/search_model.dart';
import 'package:http/http.dart' as http;

class SearchNurse extends GetxController {
  var isLoading = true.obs;
  final nameController = TextEditingController();
  Timer? debounce;

  var searchnurse = <SearchModel>[].obs;

  @override
  void onClose() {
    debounce!.cancel();
    nameController.dispose();
    searchnurse.close();
    super.onClose();
  }

  Future<List<SearchModel>> searchNursebyName(String name) async {
    searchnurse.clear();
    isLoading(true);
    try {
      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/nurse/search/$name');

      final response = await http.get(url);
      final nurseData = json.decode(response.body)['data'];

      if (nurseData == null) {
        //print('data tidak ditemukan');
        isLoading(false);
        return searchnurse;
      }

      final List data = nurseData;

      searchnurse.value = data.map((e) => SearchModel.fromJson(e)).toList();

      isLoading(false);

      return searchnurse;
    } catch (e) {
      isLoading(false);
      throw Exception(e);
    }
  }
}
