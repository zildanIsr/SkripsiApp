import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/stepindex_controller.dart';
import 'package:flutter_application_1/extensions/timeofday_extensions.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Controllers/regisnurse_controller.dart';

class RegisterPerawatView extends StatelessWidget {
  const RegisterPerawatView({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Keluar dari halaman'),
              content: const Text('Data register anda tidak akan tersimpan?'),
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
      appBar: AppBar(
        title: const Text('Daftar Perawat'),
      ),
      body: WillPopScope(onWillPop: showExitPopup, child: const FormRegister()),
    );
  }
}

class FormRegister extends StatelessWidget {
  const FormRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final ctx = Get.put(StepsFormRegisterController());
    RegisNurseController regiscontroller = Get.put(RegisNurseController());

    List<Step> getSteps() {
      return <Step>[
        Step(
          state: ctx.stepIndex >= 0 ? StepState.complete : StepState.disabled,
          isActive: ctx.stepIndex >= 0,
          title: Text(ctx.stepIndex == 0 ? "Identitas Perawat" : ""),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tempat Praktik',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Praktik boleh kosong';
                  }
                  return null;
                },
                controller: regiscontroller.clinicField,
                autofocus: true,
                decoration: const InputDecoration(
                  //labelText: 'Masukan Nama',
                  hintText: 'Tempat praktik',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Nomor STR',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'STR tidak boleh kosong';
                  }
                  return null;
                },
                controller: regiscontroller.strNumber,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  //labelText: 'Masukan Nama',
                  hintText: 'nomor STR',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Nomor SIP',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                controller: regiscontroller.sipNumber,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  //labelText: 'Masukan Nama',
                  hintText: 'nomor SIP (opsional)',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Lama Bekerja',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
                controller: regiscontroller.exYearField,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  //labelText: 'Masukan Nama',
                  hintText: 'Tahun',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
        Step(
          title: Text(ctx.stepIndex == 1 ? "Pendidikan" : ""),
          isActive: ctx.stepIndex >= 1,
          state: ctx.stepIndex >= 1 ? StepState.complete : StepState.indexed,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pendidikan Pertama',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pendidikan pertama tidak boleh kosong';
                  }
                  return null;
                },
                controller: regiscontroller.feductionField,
                autofocus: true,
                decoration: const InputDecoration(
                  //labelText: 'Masukan Nama',
                  hintText: 'D3/S1 Pendidikan',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Pendidikan Kedua (opsional)',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                controller: regiscontroller.seducationField,
                autofocus: true,
                decoration: const InputDecoration(
                  //labelText: 'Masukan Nama',
                  hintText: 'S2 Pendidikan',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Pendidikan Ketiga (opsional)',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                controller: regiscontroller.teducationField,
                autofocus: true,
                decoration: const InputDecoration(
                  //labelText: 'Masukan Nama',
                  hintText: 'S3 pendidikan',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
        Step(
            title: Text(ctx.stepIndex == 2 ? "Jadwal Homecare" : ""),
            isActive: ctx.stepIndex >= 2,
            state: ctx.stepIndex >= 2 ? StepState.complete : StepState.indexed,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CheckboxDay(),
                const SizedBox(
                  height: 8.0,
                ),
                const Divider(),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                    width: double.infinity,
                    height: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Jam Buka',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Harus diisi';
                                    }
                                    return null;
                                  },
                                  controller: regiscontroller.openTimeField,
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.timelapse_outlined),
                                    hintText: 'Pilih Waktu',
                                    isDense: true,
                                  ),
                                  readOnly: true,
                                  onTap: (() async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime:
                                          const TimeOfDay(hour: 6, minute: 0),
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child ?? Container(),
                                        );
                                      },
                                    );
                                    if (pickedTime != null) {
                                      regiscontroller.openTimeField.text =
                                          pickedTime.to24hours();
                                      regiscontroller
                                          .timeOpenChanged(pickedTime);
                                    }
                                  })),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 32.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Jam Tutup',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Jam harus diisi';
                                    }
                                    return null;
                                  },
                                  controller: regiscontroller.closeTimeField,
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.timelapse_outlined),
                                    hintText: 'Pilih Waktu',
                                    isDense: true,
                                  ),
                                  readOnly: true,
                                  onTap: (() async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: regiscontroller.open.value,
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child ?? Container(),
                                        );
                                      },
                                    );
                                    if (pickedTime != null) {
                                      regiscontroller.closeTimeField.text =
                                          pickedTime.to24hours();
                                      regiscontroller
                                          .timeCloseChanged(pickedTime);
                                    }
                                  })),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            )),
        Step(
            title: Text(ctx.stepIndex == 3 ? "Upload Dokumen" : ""),
            isActive: ctx.stepIndex >= 3,
            state: ctx.stepIndex >= 3 ? StepState.complete : StepState.indexed,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload Dokumen Pendukung',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  'Upload Lamaran',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          readOnly: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'File harus diupload';
                            } else {
                              return null;
                            }
                          },
                          controller: regiscontroller.fileUpload,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            hintText: 'Upload Lamaran',
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          style: const TextStyle(fontSize: 16.0)),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.upload_file,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      label: const Text('Pilih File',
                          style: TextStyle(fontSize: 16.0)),
                      onPressed: () {
                        regiscontroller.selectFile();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(122, 48),
                        maximumSize: const Size(122, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  ' ekstensi file .pdf',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  'Upload bukti nomor STR',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          readOnly: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'File harus diupload';
                            } else {
                              return null;
                            }
                          },
                          controller: regiscontroller.file2Upload,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            hintText: 'Upload bukti',
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          style: const TextStyle(fontSize: 16.0)),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.upload_file,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      label: const Text('Pilih File',
                          style: TextStyle(fontSize: 16.0)),
                      onPressed: () {
                        regiscontroller.selectFileSTR();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(122, 48),
                        maximumSize: const Size(122, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  ' ekstensi file .pdf',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: regiscontroller.aggreement.value,
                        onChanged: (val) {
                          regiscontroller.aggreement(val);
                        })),
                    const Expanded(
                        child: Text(
                      'Dengan ini saya menyetujui semua peryaratan dan ketentuan yang berlaku',
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                      softWrap: true,
                    ))
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            )),
      ];
    }

    return GetBuilder<StepsFormRegisterController>(
        init: StepsFormRegisterController(),
        builder: (context) {
          return Stepper(
            currentStep: context.stepIndex,
            physics: const ScrollPhysics(),
            type: StepperType.horizontal,
            onStepCancel: () {
              context.onStepCancel();
            },
            onStepContinue: () {
              bool isLastStep = (context.stepIndex == getSteps().length - 1);
              if (isLastStep) {
              } else {
                regiscontroller.validation();
                context.onStepContinue();
              }
            },
            onStepTapped: (int index) {
              context.onStepTapped(index);
            },
            controlsBuilder: (context, controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (ctx.stepIndex != 0)
                    TextButton(
                      onPressed: controller.onStepCancel,
                      child: const Text('Kembali'),
                    ),
                  if (ctx.stepIndex != getSteps().length - 1)
                    ElevatedButton(
                      onPressed: controller.onStepContinue,
                      child: const Text('Lanjut'),
                    ),
                  if (ctx.stepIndex == getSteps().length - 1)
                    Obx(() => regiscontroller.isLoading.value
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24),
                            child: Center(
                              child: LoadingAnimationWidget.discreteCircle(
                                  color: Colors.pink, size: 24),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              regiscontroller.onSubmit();
                            },
                            child: const Text('Daftar'),
                          )),
                ],
              );
            },
            steps: getSteps(),
          );
        });
  }
}

class CheckboxDay extends StatefulWidget {
  const CheckboxDay({super.key});

  @override
  State<CheckboxDay> createState() => _CheckboxDayState();
}

class _CheckboxDayState extends State<CheckboxDay> {
  List<Map> availableDay = [
    {"name": "Senin", "isChecked": false},
    {"name": "Selasa", "isChecked": false},
    {
      "name": "Rabu",
      "isChecked": false,
    },
    {"name": "Kamis", "isChecked": false},
    {"name": "Jum'at", "isChecked": false},
    {"name": "Sabtu", "isChecked": false},
    {"name": "Minggu", "isChecked": false}
  ];

  RegisNurseController checkboxController = Get.find<RegisNurseController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Pilih Jadwal Layanan:',
                style: TextStyle(fontSize: 20),
              ),
              Column(
                  children: availableDay.map((value) {
                return CheckboxListTile(
                    visualDensity: VisualDensity.comfortable,
                    value: value["isChecked"],
                    title: Text(value["name"]),
                    onChanged: (newValue) {
                      setState(() {
                        value["isChecked"] = newValue;
                        if (value["isChecked"] == true) {
                          checkboxController.addDayOpen(value["name"]);
                        } else {
                          checkboxController.removeDayOpen(value["name"]);
                        }
                      });
                    });
              }).toList()),
            ])));
  }
}
