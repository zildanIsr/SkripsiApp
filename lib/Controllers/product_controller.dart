import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/product_model.dart';
import 'package:http/http.dart' as http;

import '../services/secure_storage.dart';

class ProductController extends GetxController {
  final StorageService _storageService = StorageService();
  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = "".obs;

  var listProduct = <Product>[].obs;
  var myProduct = <Product>[].obs;

  final selectedCategory = 0.obs;
  final selprice = 0.obs;

  @override
  void onInit() {
    getmyProducts();
    super.onInit();
  }

  @override
  void onClose() {
    listProduct.clear();
    myProduct.clear();
    super.onClose();
  }

  Future<List<Product>> getAllProductList(int id) async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');

      Uri url = Uri.parse(
          'http://192.168.100.4:3500/v1/api/product/$id/productbyCategory');

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
          const Duration(seconds: 3),
          () => {
                listProduct.value =
                    data.map((e) => Product.fromJson(e)).toList()
              });

      isLoading(false);
      isError(false);

      return listProduct;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Product>> getmyProducts() async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');

      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/product/productbyNurse');

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
          const Duration(seconds: 3),
          () => {
                myProduct.value = data.map((e) => Product.fromJson(e)).toList()
              });

      isLoading(false);
      isError(false);

      return myProduct;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  bool _validation() {
    if (selprice.value == 0) {
      return false;
    }
    if (selectedCategory.value == 0) {
      return false;
    }
    return true;
  }

  Future<void> refreshData() async {
    try {
      myProduct.clear();
      getmyProducts();
    } catch (e) {
      throw Exception(e);
    }
  }

  addNewProduct() async {
    if (_validation()) {
      isLoading(true);
      try {
        var token = await _storageService.readSecureData('token');

        Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/product/create');

        Map<String, dynamic> data = {
          "price": selprice.value,
          "categoryId": selectedCategory.value,
        };

        final response = await http.post(url,
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: json.encode(data));

        if (response.statusCode >= 400 && response.statusCode < 500) {
          Get.snackbar(
            'Error',
            '',
            messageText: const Text(
              'Gagal mendaftar sebagai perawat',
              style: TextStyle(fontSize: 16.0),
            ),
            snackPosition: SnackPosition.TOP,
          );
          isLoading(false);
          isError(true);
          return;
        }

        if (response.statusCode >= 500) {
          Get.snackbar(
            'Error',
            '',
            messageText: const Text(
              'Gagal mendaftar sebagai perawat',
              style: TextStyle(fontSize: 16.0),
            ),
            snackPosition: SnackPosition.TOP,
          );
          isLoading(false);
          isError(true);
          return;
        }

        if (response.statusCode >= 200 && response.statusCode < 300) {
          // final resListFormat = json.decode(response.body)['data'];
          // //print(resListFormat);
          // myProduct.insert(0, resListFormat);
          getmyProducts();

          Get.snackbar(
            "Success",
            '',
            messageText: const Text(
              'Berhasil mendaftar sebagai perawat',
              style: TextStyle(fontSize: 16.0),
            ),
            snackPosition: SnackPosition.TOP,
          );
          Future.delayed(const Duration(seconds: 2), () {
            isLoading(false);
            isError(false);
            Get.back();
          });
        }
      } catch (e) {
        isLoading(false);
        isError(true);
        errmsg(e.toString());
      }
    } else {
      Get.snackbar(
        'Error',
        '',
        messageText: const Text(
          "Kategori atau harga tidak boleh kosong",
          style: TextStyle(fontSize: 16.0),
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void setPrice(int val) {
    selprice.value = val;
  }

  void onChangedSelectedCat(int val) {
    selectedCategory.value = val;
  }
}
