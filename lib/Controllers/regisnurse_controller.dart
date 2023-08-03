import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../services/api_service.dart';
import '../services/secure_storage.dart';
import '../services/simple_storage.dart';
import '../widgets/bottom_navbar.dart';
import 'auth.dart';
import 'package:file_picker/file_picker.dart';

class RegisNurseController extends GetxController {
  final openTimeField = TextEditingController();
  final closeTimeField = TextEditingController();

  final clinicField = TextEditingController();
  final strNumber = TextEditingController();
  final sipNumber = TextEditingController();
  final exYearField = TextEditingController();

  final feductionField = TextEditingController();
  final seducationField = TextEditingController();
  final teducationField = TextEditingController();

  final fileUpload = TextEditingController();
  final file2Upload = TextEditingController();

  List<String> dayOpen = <String>[].obs;
  List<String> education = <String>[].obs;
  List<String> timeRange = <String>[].obs;

  Rx<TimeOfDay> open = TimeOfDay.now().obs;
  Rx<TimeOfDay> close = TimeOfDay.now().obs;

  RxBool aggreement = false.obs;
  late File uploadCV;
  late File uploadSTR;

  RxString errorText = 'Error'.obs;
  final StorageService _storageService = StorageService();
  final SharedStorage sharedService = SharedStorage();
  final APIService _apiservice = APIService();
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
    sipNumber.dispose();

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

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      fileUpload.text = result.files.single.name;
      uploadCV = File(result.files.single.path.toString());
    } else {
      // User canceled the picker
    }
  }

  selectFileSTR() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      file2Upload.text = result.files.single.name;
      uploadSTR = File(result.files.single.path.toString());
    } else {
      // User canceled the picker
    }
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
    if (dayOpen.isEmpty) {
      errorText.value = 'Jadwal Tidak Boleh Kosong';
      return false;
    }
    if (!aggreement.value) {
      errorText.value = 'Persetujuan belum diceklis';
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

        var geturl = _apiservice.getURL("v1/api/nurse/create");

        Uri url = Uri.parse(geturl);

        var token = await _storageService.readSecureData('token');

        /*
        workPlace: DataTypes.STRING,
        strNumber: DataTypes.STRING,
        SIPNumber: DataTypes.STRING,
        education: DataTypes.ARRAY(DataTypes.STRING),
        workTime: DataTypes.STRING,
        timeRange: DataTypes.ARRAY(DataTypes.STRING),
        dayActive: DataTypes.ARRAY(DataTypes.STRING),
        status: DataTypes.BOOLEAN,
        document: DataTypes.BLOB,
        strFile: DataTypes.BLOB,
        agreement: DataTypes.BOOLEAN,
        userId: DataTypes.INTEGER,
        */
        var request = http.MultipartRequest('POST', url);
        request.headers.addAll({
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $token",
        });

        request.fields.addAll({
          "workPlace": clinicField.text,
          "strNumber": strNumber.text,
          "SIPNumber": sipNumber.text,
          "workTime": exYearField.text,
        });

        for (var i = 0; i < education.length; i++) {
          request.fields["education$i"] = education[i];
        }

        for (var i = 0; i < dayOpen.length; i++) {
          request.fields["dayActive$i"] = dayOpen[i];
        }

        for (var i = 0; i < timeRange.length; i++) {
          request.fields["timeRange$i"] = timeRange[i];
        }
        request.files
            .add(await http.MultipartFile.fromPath('document', uploadCV.path));
        request.files
            .add(await http.MultipartFile.fromPath('document', uploadSTR.path));

        http.Response response =
            await http.Response.fromStream(await request.send());
        // Nurse data = Nurse(
        //   workPlace: clinicField.text,
        //   strNumber: strNumber.text,
        //   education: education,
        //   workTime: exYearField.text,
        //   timeRange: timeRange,
        //   dayActive: dayOpen,
        //   createdAt: DateTime.now(),
        //   updatedAt: DateTime.now(),
        // );

        // final response = await http.post(url,
        //     headers: {
        //       "Accept": "application/json",
        //       "Content-Type": "application/json",
        //       "Authorization": "Bearer $token",
        //     },
        //     body: json.encode(data));

        if (response.statusCode >= 400 && response.statusCode < 500) {
          Get.snackbar("Gagal mendaftar", "",
              messageText: const Text(
                "Nomor STR sudah digunakan",
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
          Future.delayed(const Duration(seconds: 1), () {
            isLoading(false);
            isError(false);
            Get.off(() => const BottomNavbar());
          });

          return Get.snackbar("Berhasil", "",
              messageText: const Text(
                "Pendaftaran Sedang Diverifikasi",
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
