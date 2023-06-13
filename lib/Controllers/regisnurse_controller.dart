import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/perawat_model.dart';
import '../Models/user_model.dart' as usermodel;
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../Models/storage_item.dart';
import '../services/secure_storage.dart';
import '../services/simple_storage.dart';
import '../widgets/bottom_navbar.dart';
import 'auth.dart';

class RegisNurseController extends GetxController {
  final openTimeField = TextEditingController();
  final closeTimeField = TextEditingController();

  final clinicField = TextEditingController();
  final strNumber = TextEditingController();
  final exYearField = TextEditingController();

  final feductionField = TextEditingController();
  final seducationField = TextEditingController();
  final teducationField = TextEditingController();

  List<String> dayOpen = <String>[].obs;
  List<String> education = <String>[].obs;
  List<String> timeRange = <String>[].obs;

  Rx<TimeOfDay> open = TimeOfDay.now().obs;
  Rx<TimeOfDay> close = TimeOfDay.now().obs;

  RxString errorText = 'Error'.obs;
  final StorageService _storageService = StorageService();
  final SharedStorage sharedService = SharedStorage();
  AuthController ac = Get.put(AuthController());

  var isLoading = false.obs;
  var isError = false.obs;

  @override
  void onClose() {
    openTimeField.dispose();
    closeTimeField.dispose();
    clinicField.dispose();
    strNumber.dispose();
    exYearField.dispose();
    feductionField.dispose();
    seducationField.dispose();
    teducationField.dispose();

    dayOpen.clear();
    education.clear();
    timeRange.clear();
    super.onClose();
  }

  addDayOpen(String val) {
    dayOpen.add(val);
    //print(dayOpen);
  }

  removeDayOpen(String val) {
    dayOpen.remove(val);
  }

  void timeOpenChanged(TimeOfDay val) {
    open.value = val;
  }

  void timeCloseChanged(TimeOfDay val) {
    close.value = val;
  }

  bool validation() {
    if (openTimeField.text.trim().isEmpty) {
      errorText.value = 'Jam Buka Tidak Boleh Kosong';
      return false;
    }
    if (closeTimeField.text.trim().isEmpty) {
      errorText.value = 'Jam Tutup Tidak Boleh Kosong';
      return false;
    }
    if (clinicField.text.trim().isEmpty) {
      errorText.value = 'Tempat Praktik Tidak Boleh Kosong';
      return false;
    }
    if (strNumber.text.trim().isEmpty) {
      errorText.value = 'Nomor STR Tidak Boleh Kosong';
      return false;
    }
    if (feductionField.text.trim().isEmpty) {
      errorText.value = 'Pendidikan Pertama Tidak Boleh Kosong';
      return false;
    }
    // if (open.value.hour.) {
    //   errorText.value = 'Jadwal Tidak Boleh Kosong';
    //   return false;
    // }
    if (dayOpen.isEmpty) {
      errorText.value = 'Jadwal Tidak Boleh Kosong';
      return false;
    }
    return true;
  }

  onSubmit() async {
    if (validation()) {
      isLoading(true);
      try {
        if (education.length < 3) {
          education.add(
            feductionField.text,
          );
          if (seducationField.text != '') {
            education.add(
              seducationField.text,
            );
          }
          if (teducationField.text != '') {
            education.add(
              teducationField.text,
            );
          }
        }

        if (timeRange.length < 2) {
          timeRange.addAll([openTimeField.text, closeTimeField.text]);
        }

        // print('${clinicField.text}, ${strNumber.text}, ${exYearField.text}');
        // print(dayOpen);
        // print(education);
        // print(timeRange);

        Uri url = Uri.parse('http://192.168.100.4:3500/v1/api/nurse/create');

        var token = await _storageService.readSecureData('token');

        Nurse data = Nurse(
          workPlace: clinicField.text,
          strNumber: strNumber.text,
          education: education,
          workTime: exYearField.text,
          timeRange: timeRange,
          dayActive: dayOpen,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final response = await http.post(url,
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: json.encode(data));

        if (response.statusCode >= 400 && response.statusCode < 500) {
          Get.snackbar("Error", "Server Error",
              messageText: const Text(
                "Gagal mendaftarkan",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red.shade300);
          isLoading(false);
          isError(true);
          return;
        }

        if (response.statusCode >= 500) {
          Get.snackbar("Error", "Server Error",
              messageText: const Text(
                "Gagal mendaftar",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red.shade300);
          isLoading(false);
          isError(true);
          return;
        }

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var resbody = json.decode(response.body)['data'];
          var nurse = json.decode(response.body)['nurse'];
          sharedService
              .addStringToSF(StorageItem('user', json.encode(resbody)));

          ac.user = usermodel.User.fromJson(resbody);
          //print('str:  ${nurse['strNumber']}');
          if (nurse != null) {
            ac.strNumber.value = nurse['strNumber'] ?? '';
            sharedService
                .addStringToSF(StorageItem('strNumber', ac.strNumber.value));
          }

          Future.delayed(const Duration(seconds: 3), () {
            isLoading(false);
            isError(false);
            Get.off(() => const BottomNavbar());
          });

          return Get.snackbar("Success", "",
              messageText: const Text(
                "Berhasil mendaftar perawat",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green.shade300);
        }
      } catch (e) {
        e.printError();
        isLoading(false);
        isError(true);
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
