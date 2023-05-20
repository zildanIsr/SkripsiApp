import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/perawat_model.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../services/secure_storage.dart';
import '../services/simple_storage.dart';
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
    print(dayOpen);
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

  String? geterrorText() {
    final clinic = clinicField.value.text;
    final opentime = openTimeField.value.text;
    final closetime = closeTimeField.value.text;
    final str = strNumber.value.text;
    final firstEdu = feductionField.value.text;

    if (opentime.isEmpty) {
      return 'Jam Buka Tidak Boleh Kosong';
    }
    if (closetime.isEmpty) {
      return 'Jam Tutup Tidak Boleh Kosong';
    }
    if (clinic.isEmpty) {
      return 'Tempat Praktik Tidak Boleh Kosong';
    }
    if (str.isEmpty) {
      return 'Nomor STR Tidak Boleh Kosong';
    }
    if (firstEdu.isEmpty) {
      return 'Pendidikan Pertama Tidak Boleh Kosong';
    }
    if (dayOpen.isEmpty) {
      return 'Jadwal Tidak Boleh Kosong';
    }
    return null;
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
          education.addAll([
            feductionField.text,
            seducationField.text,
            teducationField.text
          ]);
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
          Get.snackbar(
            'Error',
            errorText.value,
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
            errorText.value,
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
          Get.snackbar(
            "Success",
            errorText.value,
            messageText: const Text(
              'Berhasil mendaftar sebagai perawat',
              style: TextStyle(fontSize: 16.0),
            ),
            snackPosition: SnackPosition.TOP,
          );
          Future.delayed(const Duration(seconds: 5), () {
            isLoading(false);
            isError(false);
            Get.back();
          });
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
