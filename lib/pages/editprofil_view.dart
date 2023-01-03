import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Controllers/edit_form.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
  Get.put(EditFormController());

  return Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      title: const Text('Edit Profile'),
    ),
    body: const EditForm()
   );
  }
}

class EditForm extends GetView<EditFormController> {
  const EditForm({super.key});
  
  @override
  Widget build(BuildContext context) {

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
                      TextSpan(text: '*', style: TextStyle(fontSize: 16.0, color: Colors.red)),
                    ],
                  ),
                )
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nama Lengkap',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4.0,),    
                    TextFormField(
                      controller: controller.nameController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        //labelText: 'Masukan Nama',
                        hintText: 'Masukin nama',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    const Text(
                      'Tanggal Lahir',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4.0,),    
                    TextFormField(
                      controller: controller.birthController,
                      autofocus: true,
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
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);                          
                          controller.birthController.text = formattedDate;
                        } 
                        else {
                          
                        }
                      })
                    ),
                    const SizedBox(height: 16.0,),
                    const Text(
                      'Jenis Kelamin',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8.0,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            (() => 
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: 0, 
                                title: const Text('Laki-laki'),
                                groupValue: controller.sexController.value,
                                onChanged: ((val) {
                                  //debugPrint(controller.sexController.value.toString());
                                  controller.onChangedSelectedSex(val);
                                })
                              )
                            )
                            )
                          ),
                          Obx(
                            (() => 
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: 1, 
                                title: const Text('Perempuan'),
                                groupValue: controller.sexController.value, 
                                onChanged: ((val) {
                                  //debugPrint(controller.sexController.value.toString());
                                  controller.onChangedSelectedSex(val);
                                })
                              )
                            )
                            )
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    const Text(
                      'Nomor Telepon',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8.0,),
                    TextFormField(
                      controller: controller.phoneController,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        //labelText: 'Masukan Nama',
                        hintText: '08xxxx',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          controller.onSubmit();
                        }, 
                        child: const Text('Simpan')
                      ),
                    )
                  ],
                ),
              )
            ],
        )
      ),
    );
  }
  
  
}