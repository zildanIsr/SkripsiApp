import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/storage_item.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/address_model.dart';
import '../services/secure_storage.dart';
import '../services/simple_storage.dart';

class AddressController extends GetxController {
  final StorageService _storageService = StorageService();
  final SharedStorage sharedService = SharedStorage();

  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = "".obs;
  var selectedAddress = 0.obs;

  var addressbyUser = <AddressModel>[].obs;

  @override
  void onInit() {
    getSelectedAddress();
    getAllAddressbyUser();
    super.onInit();
  }

  @override
  void onClose() {
    addressbyUser.close();
    errmsg.close();
    isLoading.close();
    isError.close();
    super.onClose();
  }

  void onChangedSelectedAddress(val) async {
    await sharedService.addIntToSF(StorageItem('selectedAddress', val));
    selectedAddress.value = val;
  }

  void getSelectedAddress() async {
    selectedAddress.value =
        await sharedService.getIntValuesSF('selectedAddress') ?? 0;
  }

  void stringAddress(val) async {
    await sharedService.addStringToSF(StorageItem('stringAddress', val));
  }

  void getstringAddress() async {
    await sharedService.getStringValuesSF('stringAddress') ?? '';
  }

  Future<List<AddressModel>> getAllAddressbyUser() async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');

      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/address/getbyuser');

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
                addressbyUser.value =
                    data.map((e) => AddressModel.fromJson(e)).toList()
              });

      isLoading(false);
      isError(false);

      return addressbyUser;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  addNewAddress(AddressModel data) async {
    isLoading(true);
    try {
      Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/address/create');

      var token = await _storageService.readSecureData('token');

      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        getAllAddressbyUser();
      }

      Future.delayed(
          const Duration(seconds: 2), () => {isLoading(false), isError(false)});

      return response.statusCode;
    } catch (e) {
      isLoading(false);
      isError(true);
      errmsg(e.toString());
      throw Exception(e);
    }
  }

  deletedAddress(int id) async {
    isLoading(true);
    try {
      var token = await _storageService.readSecureData('token');
      Uri url =
          Uri.parse('http://192.168.100.4:3500/v1/api/address/delete/$id');

      final response = await http.delete(
        url,
        headers: {
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
            'Gagal menghapus alamat',
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
        addressbyUser.clear();
        getAllAddressbyUser();

        Get.snackbar(
          'Berhasil',
          '',
          colorText: Colors.white,
          messageText: const Text(
            'Berhasil menghapus alamat',
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
      addressbyUser.clear();
      getAllAddressbyUser();
    } catch (e) {
      throw Exception(e);
    }
  }
}
