import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditFormController extends GetxController {
  final editFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  var sexController = 1.obs;
  final phoneController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    birthController.dispose();
    sexController.close();
    phoneController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.onClose();
  }

  void onChangedSelectedSex(val) {
    sexController.value = val;
  }

  void onSubmit() {
    checkForm(nameController.text, birthController.text, sexController.value,
        phoneController.text);
  }

  void checkForm(String name, String date, int sex, String phone) {
    Map<String, dynamic> data = {
      'Name': name,
      'Date': date,
      'sex': sex,
      'phone': phone
    };
    debugPrint(data.toString());
  }
}
