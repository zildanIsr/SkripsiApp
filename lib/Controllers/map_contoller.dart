import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/map_model.dart';
import '../Models/product_model.dart';
//import '../services/secure_storage.dart';
//import '../services/simple_storage.dart';

class MapController extends GetxController {
  //final StorageService _storageService = StorageService();
  //final SharedStorage sharedService = SharedStorage();

  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = "".obs;

  var position = <MapModel>[].obs;
  var productPoint = <Product>[].obs;

  Future<List<MapModel>> getAllNurseAddress() async {
    isLoading(true);
    try {
      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/nurse/nurseAddress');

      final response = await http.get(
        url,
      );

      final resListFormat = json.decode(response.body)['data'];

      if (resListFormat == null) {
        //print('tidak ada data');
        isLoading(false);
        isError(true);
      }
      //print(resListFormat);
      final List data = resListFormat;

      position.value = data.map((e) => MapModel.fromJson(e)).toList();

      isLoading(false);
      isError(false);

      return position;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Product>> getProduct(int id) async {
    isLoading(true);
    try {
      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/product/$id/productbyId');

      final response = await http.get(
        url,
      );

      final resListFormat = json.decode(response.body)['data'];

      if (resListFormat == null) {
        //print('tidak ada data');
        isLoading(false);
        isError(true);
      }
      //print(resListFormat);
      final List data = resListFormat;

      productPoint.value = data.map((e) => Product.fromJson(e)).toList();

      isLoading(false);
      isError(false);

      return productPoint;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }
}
