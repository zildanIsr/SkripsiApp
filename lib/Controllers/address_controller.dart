import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/storage_item.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/address_model.dart';
import '../Models/nearbylocation_model.dart';
import '../services/api_service.dart';
import '../services/secure_storage.dart';
import '../services/simple_storage.dart';

import 'package:url_launcher/url_launcher.dart';

class AddressController extends GetxController {
  final StorageService _storageService = StorageService();
  final SharedStorage sharedService = SharedStorage();
  final APIService _apiservice = APIService();

  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = "".obs;
  var selectedAddress = 0.obs;

  var addressbyUser = <AddressModel>[].obs;
  var nearbyLocation = <NearbyLocation>[].obs;

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

      var geturl = _apiservice.getURL("v1/api/address/getbyuser");

      Uri url = Uri.parse(geturl);

      //Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/address/getbyuser');

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
      var geturl = _apiservice.getURL("v1/api/address/create");

      Uri url = Uri.parse(geturl);

      //Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/address/create');

      var token = await _storageService.readSecureData('token');

      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await getAllAddressbyUser();
      }

      Future.delayed(
          const Duration(seconds: 3), () => {isLoading(false), isError(false)});

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

      var geturl = _apiservice.getURL("v1/api/address/delete/$id");
      //Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/address/delete/$id');

      Uri url = Uri.parse(geturl);

      final response = await http.put(
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

  launchMapsUrl(String destinationPlaceId) async {
    var originPlaceId =
        await sharedService.getStringValuesSF('stringAddress') ?? '';

    if (originPlaceId == '') {
      return Get.snackbar(
        'Gagal',
        '',
        colorText: Colors.white,
        messageText: const Text(
          'Alamat utama belum dipilih',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        backgroundColor: Colors.red.shade400,
        snackPosition: SnackPosition.TOP,
      );
    }

    var encodeOrigin = Uri.encodeComponent(originPlaceId);
    var encodeDest = Uri.encodeComponent(destinationPlaceId);

    String mapOptions = [
      'origin=$encodeOrigin',
      'destination=$encodeDest',
      'dir_action=navigate'
    ].join('&');

    final googleUrl = 'https://www.google.com/maps/dir/?api=1&$mapOptions';

    Uri url = Uri.parse(googleUrl);
    if (await launchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar(
        'Gagal',
        '',
        colorText: Colors.white,
        messageText: const Text(
          'Gagal membuka WhatsApp',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        backgroundColor: Colors.red.shade400,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<List<NearbyLocation>> getParmachiNearby(
      String latitude, String longitude) async {
    isLoading(true);
    try {
      var api =
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude%2C$longitude&radius=1500&type=pharmacy&keyword=pharmacy&opennow=true&key=AIzaSyBW1Il79q019RZeeDLaZIK3BFX18lhou_4';
      Uri url = Uri.parse(api);

      final response = await http.get(url);
      final resListFormat = json.decode(response.body)['results'];

      if (resListFormat == null) {
        //print('tidak ada data');
        isLoading(false);
        isError(true);
      }

      final List data = resListFormat;

      await Future.delayed(
          const Duration(seconds: 1),
          () => {
                nearbyLocation.value =
                    data.map((e) => NearbyLocation.fromJson(e)).toList()
              });

      isLoading(false);
      isError(false);

      return nearbyLocation;
    } catch (e) {
      isLoading(false);
      isError(true);
      Get.snackbar(
        'Gagal',
        '',
        colorText: Colors.white,
        messageText: const Text(
          'Gagal memuat lokasi',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        backgroundColor: Colors.red.shade400,
        snackPosition: SnackPosition.TOP,
      );
      throw Exception(e);
      //return nearbyLocation;
    }
  }
}
