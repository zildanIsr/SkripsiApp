import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditFormController extends GetxController{
  final editFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  var sexController = 0.obs;
  final List <Map<int,String>> gender = [{0 : 'Laki-laki'}, {1 : 'Perempuan'}];
  final phoneController = TextEditingController();  
  
  @override
  void onInit() {
    debugPrint('onInit');
    super.onInit();
  }

  @override
  void onReady() {
    debugPrint('onReady');
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    birthController.dispose();
    //sexController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void onChangedSelectedSex(val){
    sexController.value = val;
  }

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Tidak Boleh Kosong';
    }
    return null;
  }

  void onSubmit() {
    if (editFormKey.currentState!.validate()) {
      checkForm(nameController.text, birthController.text, sexController.value, phoneController.text);
    }
  }

  void checkForm (String name, String date, int sex, String phone) {
    Map<String, dynamic> data = {'Name' : name, 'Date' : date, 'sex' : sex, 'phone' : phone};
    debugPrint(data.toString());
  }



}