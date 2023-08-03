import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/user_controller.dart';
import 'package:flutter_application_1/pages/auth_view.dart';
import 'package:flutter_application_1/pages/detail_pengguna.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:io';

import '../Controllers/auth.dart';
import '../Controllers/nurse_data.dart';
import 'detail_perawat.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AccountSetting());
  }
}

//Pasien Profile
class AccountSetting extends StatelessWidget {
  const AccountSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidht = MediaQuery.of(context).size.width;

    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;

    AuthController ac = Get.find();

    return SizedBox(
        width: mediaQueryWidht,
        height: bodyHeight,
        child: Column(
          children: [
            SizedBox(
              height: bodyHeight * 0.31,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child: Container(
                      width: double.infinity,
                      height: bodyHeight * 0.2,
                      decoration: BoxDecoration(
                          color: ac.user.roleId == 1
                              ? Colors.green.shade300
                              : Colors.pink.shade400,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(170),
                              bottomRight: Radius.circular(170))),
                    ),
                  ),
                  const ImageCircle(),
                ],
              ),
            ),
            const ProfileCard(),
            const ButtonList()
          ],
        ));
  }
}

class ImageCircle extends StatefulWidget {
  const ImageCircle({
    super.key,
  });

  @override
  State<ImageCircle> createState() => _ImageCircleState();
}

class _ImageCircleState extends State<ImageCircle> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  AuthController ac = Get.find();

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      ac.uploadImage(File(pickedImage.path));
    }

    setState(() {
      _pickedImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Positioned(
      top: bodyHeight > 700 ? 85 : 55,
      left: 0,
      right: 0,
      child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: [
            Obx(
              () => ac.isLoading.value
                  ? const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70,
                      child: CircleAvatar(
                        //backgroundImage: FileImage(File(_pickedImage!.path)),
                        backgroundColor: Colors.black38,
                        radius: 65,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: _pickedImage != null
                            ? FileImage(File(_pickedImage!.path))
                            : NetworkImage(ac.user.image)
                                as ImageProvider<Object>?,
                        radius: 65,
                      ),
                    ),
            ),
            Positioned(
              bottom: -15,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.green.shade200,
                child: IconButton(
                    iconSize: 22,
                    onPressed: () {
                      //print('ontap');
                      _pickImage();
                    },
                    icon: const Icon(Icons.edit)),
              ),
            ),
          ]),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController user = Get.find();

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        //color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 4.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        user.user.name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        user.user.roleId == 1 ? 'PASIEN' : 'PERAWAT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 2,
                            color: user.user.roleId == 1
                                ? Colors.green.shade500
                                : Colors.pinkAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ));
  }
}

class ButtonList extends StatelessWidget {
  const ButtonList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthController ac = Get.find();

    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;

    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Logout'),
              content: const Text('Anda yakin keluar dari akun ini?'),
              actions: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.pink)),
                  onPressed: () {
                    ac.logout();
                    Get.offAll(() => AuthView(), transition: Transition.fade);
                    Get.deleteAll();
                  },
                  child: const Text('Iya'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Tidak'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return Container(
        width: MediaQuery.of(context).size.width,
        //color: Colors.amber,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        Get.to(
                            () => DetailPengguna(
                                  id: ac.user.id,
                                ), binding: BindingsBuilder(() {
                          Get.put(UserController());
                        }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.account_circle_rounded,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Detail Akun',
                                style: TextStyle(
                                    fontSize: bodyHeight >= 700 ? 16 : 14,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_outlined,
                          ),
                        ],
                      )),
                  const Divider(),
                  ac.user.roleId == 2
                      ? Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.to(
                                      () => DetailPerawat(
                                            strNumber: ac.strNumber.value,
                                          ), binding: BindingsBuilder(() {
                                    Get.put(NurseController());
                                  }));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person_4_rounded,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Detail Perawat',
                                          style: TextStyle(
                                              fontSize:
                                                  bodyHeight >= 700 ? 16 : 14,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_outlined,
                                    ),
                                  ],
                                )),
                            const Divider(),
                          ],
                        )
                      : Container(),
                  TextButton(
                      onPressed: () {
                        Get.toNamed('/edit-profil');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.edit,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Edit Profil',
                                style: TextStyle(
                                    fontSize: bodyHeight >= 700 ? 16 : 14,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_outlined,
                          ),
                        ],
                      )),
                  const Divider(),
                  ac.user.roleId == 1
                      ? Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.toNamed('/regis-perawat');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.app_registration,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Register Perawat',
                                          style: TextStyle(
                                              fontSize:
                                                  bodyHeight >= 700 ? 16 : 14,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_outlined,
                                    ),
                                  ],
                                )),
                            const Divider(),
                          ],
                        )
                      : Container(),
                  ac.user.roleId == 2
                      ? Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.toNamed('/layanan-hc');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.medical_services,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Layanan Homecare',
                                          style: TextStyle(
                                              fontSize:
                                                  bodyHeight >= 700 ? 16 : 14,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_outlined,
                                    ),
                                  ],
                                )),
                            const Divider(),
                          ],
                        )
                      : Container(),
                  TextButton(
                      onPressed: () {
                        Get.toNamed('/address-user');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.bookmark,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Alamat Tersimpan',
                                style: TextStyle(
                                    fontSize: bodyHeight >= 700 ? 16 : 14,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_outlined,
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(bodyHeight >= 700 ? 16 : 2),
              child: TextButton(
                onPressed: () {
                  showExitPopup();
                  // ac.logout();
                  // Get.offAll(() => AuthView(), transition: Transition.fade);
                  // Get.deleteAll();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Keluar',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
