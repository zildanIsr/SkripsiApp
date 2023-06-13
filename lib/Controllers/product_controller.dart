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
  var populerProduct = <Product>[].obs;
  var productNurse = <Product>[].obs;

  final selectedCategory = 1.obs;
  final selprice = 0.obs;

  @override
  void onInit() {
    getmyProducts();
    getPopulerProduct();
    super.onInit();
  }

  @override
  void onClose() {
    listProduct.close();
    myProduct.close();
    populerProduct.close();
    productNurse.close();
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

      if (resListFormat == null) {
        //print('tidak ada data');
        isLoading(false);
        isError(true);
      }
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

  Future<List<Product>> getPopulerProduct() async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');

      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/product/populerProduct');

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final resListFormat = json.decode(response.body)['data'];

      if (resListFormat == null) {
        //print('tidak ada data');
        isLoading(false);
        isError(true);
      }
      //print(resListFormat);
      final List data = resListFormat;

      await Future.delayed(
          const Duration(seconds: 1),
          () => {
                populerProduct.value =
                    data.map((e) => Product.fromJson(e)).toList()
              });

      isLoading(false);
      isError(false);

      return populerProduct;
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

      if (!resListFormat) {
        return myProduct;
      }
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

  Future<List<Product>> productbyNurseId(int id) async {
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

      await Future.delayed(
          const Duration(seconds: 2),
          () => {
                productNurse.value =
                    data.map((e) => Product.fromJson(e)).toList()
              });

      isLoading(false);
      isError(false);

      return productNurse;
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
            colorText: Colors.white,
            messageText: const Text(
              'Gagal menambah layanan',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.red.shade400,
            snackPosition: SnackPosition.TOP,
          );
          return;
        }

        if (response.statusCode >= 500) {
          Get.snackbar(
            'Error',
            '',
            colorText: Colors.white,
            messageText: const Text(
              'Gagal kesalahan server',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.red.shade400,
            snackPosition: SnackPosition.TOP,
          );
          return;
        }

        if (response.statusCode >= 200 && response.statusCode < 300) {
          getmyProducts();

          Get.snackbar(
            'Berhasil',
            '',
            colorText: Colors.white,
            messageText: const Text(
              'Berhasil menambah layanan',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.green.shade400,
            snackPosition: SnackPosition.TOP,
          );
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

  deleteProduct(int id) async {
    isLoading(true);
    try {
      int index = myProduct.indexWhere((p) => p.id == id);

      if (index != -1) {
        var token = await _storageService.readSecureData('token');

        Uri url =
            Uri.parse('http://192.168.100.4:3500/v1/api/product/$id/delete');

        final response = await http.delete(url, headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        });

        if (response.statusCode >= 400 && response.statusCode < 500) {
          Get.snackbar(
            'Error',
            '',
            colorText: Colors.white,
            messageText: const Text(
              'Gagal menghapus layanan',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.red.shade400,
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
            colorText: Colors.white,
            messageText: const Text(
              'Kesalahan server',
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
          myProduct.removeAt(index);

          Get.snackbar(
            'Berhasil',
            '',
            colorText: Colors.white,
            messageText: const Text(
              'Berhasil menghapus layanan',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.green.shade400,
            snackPosition: SnackPosition.TOP,
          );

          await Future.delayed(const Duration(seconds: 2));
          isLoading(false);
          isError(false);
        }
      } else {
        Get.snackbar(
          'Error',
          '',
          messageText: const Text(
            'Layanan tidak ditemukan',
            style: TextStyle(fontSize: 16.0),
          ),
          snackPosition: SnackPosition.TOP,
        );
        isLoading(false);
        isError(true);
      }
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
    }
  }

  editProduct(int id) async {
    if (_validation()) {
      try {
        var token = await _storageService.readSecureData('token');

        Uri url =
            Uri.parse('http://192.168.100.4:3500/v1/api/product/update/$id');

        Map<String, dynamic> data = {
          "price": selprice.value,
        };

        final response = await http.put(url,
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
            colorText: Colors.white,
            messageText: const Text(
              'Gagal menambah layanan',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.red.shade400,
            snackPosition: SnackPosition.TOP,
          );
          return;
        }

        if (response.statusCode >= 500) {
          Get.snackbar(
            'Error',
            '',
            colorText: Colors.white,
            messageText: const Text(
              'Gagal kesalahan server',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.red.shade400,
            snackPosition: SnackPosition.TOP,
          );
          return;
        }

        if (response.statusCode >= 200 && response.statusCode < 300) {
          getmyProducts();

          Get.snackbar(
            'Berhasil',
            '',
            colorText: Colors.white,
            messageText: const Text(
              'Berhasil menambah layanan',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.green.shade400,
            snackPosition: SnackPosition.TOP,
          );
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
