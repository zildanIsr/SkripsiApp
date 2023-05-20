import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Controllers/edit_form.dart';
import '../Controllers/user_controller.dart';
import '../Models/user_model.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditFormController());

    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Keluar dari halaman'),
              content: const Text('Data suntingan anda tidak akan tersimpan?'),
              actions: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.pink)),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Iya'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Tidak'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Edit Profil'),
        ),
        body: WillPopScope(onWillPop: showExitPopup, child: const EditForm()));
  }
}

class EditForm extends GetView<EditFormController> {
  const EditForm({super.key});

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController());

    onUpdate(User data) async {
      //debugPrint('Name: ${data.name}, Password: ${data.password}');
      var responses = await uc.onUpdatedata(data);
      if (responses >= 400 && responses < 500) {
        return Get.snackbar("Error", "Gagal update data",
            colorText: Colors.white,
            messageText: const Text(
              "Gagal update data",
              style: TextStyle(fontSize: 16.0),
            ),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.shade300);
      } else if (responses >= 500) {
        return Get.snackbar("Error", "Gagal update data",
            colorText: Colors.white,
            messageText: const Text(
              "Gagal update data",
              style: TextStyle(fontSize: 16.0),
            ),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.shade300);
      } else if (responses == 200) {
        Get.back();
        return Get.snackbar("Success", "Berhasil mengubah data",
            messageText: const Text(
              "Berhasil mengubah data",
              style: TextStyle(fontSize: 16.0),
            ),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade300);
      }
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          key: controller.editFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(4),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Informasi umum',
                      style: TextStyle(fontSize: 16.0, color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.red)),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nama Lengkap',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    TextFormField(
                      controller: controller.nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        //labelText: 'Masukan Nama',
                        hintText: 'Masukin nama',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      'Tanggal Lahir',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    TextFormField(
                        controller: controller.birthController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          //labelText: 'Masukan Nama',
                          prefixIcon: Icon(Icons.calendar_today),
                          hintText: 'Pilih Tanggal',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        readOnly: true,
                        onTap: (() async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            controller.birthController.text = formattedDate;
                          } else {}
                        })),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      'Jenis Kelamin',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx((() => Expanded(
                              child: RadioListTile(
                                  value: 1,
                                  title: const Text(
                                    'Pria',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side:
                                          const BorderSide(color: Colors.grey)),
                                  groupValue: controller.sexController.value,
                                  onChanged: ((val) {
                                    //debugPrint(controller.sexController.value.toString());
                                    controller.onChangedSelectedSex(val);
                                  }))))),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Obx((() => Expanded(
                              child: RadioListTile(
                                  value: 2,
                                  title: const Text(
                                    'Wanita',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side:
                                          const BorderSide(color: Colors.grey)),
                                  groupValue: controller.sexController.value,
                                  onChanged: ((val) {
                                    //debugPrint(controller.sexController.value.toString());
                                    controller.onChangedSelectedSex(val);
                                  })))))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      'Nomor Telepon',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Telepon tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: controller.phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        //labelText: 'Masukan Nama',
                        hintText: '08xxxx',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tinggi',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                controller: controller.heightController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  //labelText: 'Masukan Nama',
                                  hintText: 'Tinggi',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Berat',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                controller: controller.weightController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  //labelText: 'Masukan Nama',
                                  hintText: 'Berat',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Obx(() => uc.isLoading.value
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: LoadingAnimationWidget.discreteCircle(
                                  color: Colors.pink, size: 32),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50)),
                            onPressed: () {
                              if (controller.editFormKey.currentState!
                                  .validate()) {
                                onUpdate(User(
                                    name: controller.nameController.text,
                                    birthDate: controller.birthController.text,
                                    sex: controller.sexController.value,
                                    phoneNumber:
                                        controller.phoneController.text,
                                    height: controller.heightController.text,
                                    weight: controller.weightController.text,
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                              //controller.onSubmit();
                            },
                            child: const Text('Simpan'))),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
