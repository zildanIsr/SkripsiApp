import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../Models/costumerorder_model.dart';
import '../Models/pesanan_model.dart';
import '../pages/detail_pesanan.dart';
import '../services/api_service.dart';
import '../services/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../services/simple_storage.dart';

class OrderConfirm extends GetxController {
  final StorageService _storageService = StorageService();
  final SharedStorage sharedService = SharedStorage();
  final APIService _apiservice = APIService();

  var isLoading = false.obs;
  var isError = false.obs;
  var errmsg = "".obs;

  final dtTextField = TextEditingController();
  final tmTextField = TextEditingController();
  final pacientTextField = TextEditingController();

  var dateOrder = DateTime.now().obs;
  var timeOrder = TimeOfDay.now().obs;
  var amPacient = 1.obs;
  var addressId = 0.obs;
  var errorText = ''.obs;
  var stringaddress = ''.obs;

  final order = Pesanan(
          orderID: '',
          dateTimePesanan: DateTime.now(),
          amountPasient: 1,
          strNumber: '',
          categoryId: 0,
          categoryName: '',
          totprice: 0,
          price: 0,
          productId: 0)
      .obs;

  @override
  void onClose() {
    dtTextField.dispose();
    tmTextField.dispose();
    pacientTextField.dispose();
    dateOrder.close();
    timeOrder.close();
    amPacient.close();
    super.onClose();
  }

  void dateOrderChanged(DateTime val) {
    dateOrder.value = val;
  }

  void timeOrderChanged(TimeOfDay val) {
    timeOrder.value = val;
  }

  // @override
  // void onInit() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     isLoading(false);
  //   });
  //   super.onInit();
  // }

  void updateLoading(bool load) {
    isLoading(load);
  }

  Future<bool> validation() async {
    if (dtTextField.text.trim().isEmpty) {
      errorText.value = 'Isi tanggal';
      return false;
    }
    if (tmTextField.text.trim().isEmpty) {
      errorText.value = 'Isi waktu';
      return false;
    }

    if (pacientTextField.text == '0') {
      errorText.value = 'Pasien tidak boleh 0';
      return false;
    }

    if (await sharedService.containkey('selectedAddress')) {
      var selectedAddress =
          await sharedService.getIntValuesSF('selectedAddress');
      addressId(selectedAddress);
      var newAddress = await sharedService.getStringValuesSF('stringAddress');
      stringaddress(newAddress);
    } else {
      errorText.value = 'Belum ada alamat';
      return false;
    }

    if (await sharedService.getIntValuesSF('selectedAddress') == 0) {
      errorText.value = 'Belum ada alamat';
      return false;
    }

    return true;
  }

  onOrder(
      String str, String catName, int catId, int price, int productId) async {
    if (await validation()) {
      try {
        var uuid = 'INV-${const Uuid().v4()}';
        order.update((val) {
          val?.dateTimePesanan = DateTime(
              dateOrder.value.year,
              dateOrder.value.month,
              dateOrder.value.day,
              timeOrder.value.hour,
              timeOrder.value.minute);
          val?.orderID = uuid;
          val?.amountPasient = amPacient.value;
          val?.strNumber = str;
          val?.categoryName = catName;
          val?.categoryId = catId;
          val?.price = price;
          val?.productId = productId;
          val?.totprice = price * amPacient.value;
        });

        Get.to(() => const DetailOrderView());
      } catch (e) {
        e.printError();
      }
    } else {
      Get.snackbar(
        'Error',
        errorText.value,
        messageText: Text(
          errorText.value,
          style: const TextStyle(fontSize: 16.0),
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  addNewOrder(Order data) async {
    isLoading(true);
    try {
      var geturl = _apiservice.getURL("v1/api/order/create");

      Uri url = Uri.parse(geturl);

      var token = await _storageService.readSecureData('token');

      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode(data));

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

  Future<void> onSubmit() async {
    return await Future.delayed(
        const Duration(seconds: 5), () => isLoading.value = false);
  }
}
