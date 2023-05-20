import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/pesanan_model.dart';
import 'package:flutter_application_1/pages/detail_pesanan.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../services/simple_storage.dart';

class OrderFormController extends GetxController {
  final SharedStorage sharedService = SharedStorage();

  final order = Pesanan(
          orderID: 'INV-0958250931',
          dateTimePesanan: DateTime.now(),
          amountPasient: 1,
          strNumber: '',
          categoryId: 0,
          categoryName: '',
          totprice: 0,
          price: 0,
          productId: 0)
      .obs;

  final dtTextField = TextEditingController();
  final tmTextField = TextEditingController();
  final pacientTextField = TextEditingController();

  Rx<DateTime> dateOrder = DateTime.now().obs;
  Rx<TimeOfDay> timeOrder = TimeOfDay.now().obs;
  var amPacient = 1.obs;
  var addressId = 0.obs;
  RxString errorText = 'text'.obs;
  var stringaddress = ''.obs;

  @override
  void onClose() {
    dtTextField.dispose();
    tmTextField.dispose();
    pacientTextField.dispose();
    dateOrder.close();
    timeOrder.close();
    amPacient.close();
    order.close();

    super.onClose();
  }

  void dateOrderChanged(DateTime val) {
    dateOrder.value = val;
  }

  void timeOrderChanged(TimeOfDay val) {
    timeOrder.value = val;
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

  Future<void> onSubmit(
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
}
