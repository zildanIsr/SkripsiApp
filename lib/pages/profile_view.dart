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
    return Center(
      child: SizedBox(
        width: mediaQueryWidht,
        height: bodyHeight,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: double.infinity,
                height: bodyHeight * 0.25,
                decoration: BoxDecoration(
                    color: ac.user.roleId == 1
                        ? Colors.green.shade300
                        : Colors.pink.shade400,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(150),
                        bottomRight: Radius.circular(150))),
              ),
            ),
            const ImageCircle(),
            ProfileCard(
              bodyHeight: bodyHeight,
              mediaQueryWidht: mediaQueryWidht,
            ),
            ButtonList(
              mediaQueryWidht: mediaQueryWidht,
            )
          ],
        ),
      ),
    );
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
    return Positioned(
      top: 85,
      left: 0,
      right: 0,
      child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 75,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: ac.user.image == null
                    ? _pickedImage != null
                        ? FileImage(File(_pickedImage!.path))
                        : const AssetImage('assets/doctor.png')
                            as ImageProvider<Object>?
                    : NetworkImage(ac.user.image),
                radius: 70,
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
    required this.bodyHeight,
    required this.mediaQueryWidht,
  }) : super(key: key);

  final double bodyHeight;
  final double mediaQueryWidht;

  @override
  Widget build(BuildContext context) {
    AuthController user = Get.find();

    return Positioned(
        top: 250,
        left: 0,
        right: 0,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 4.0,
                  child: SizedBox(
                    width: mediaQueryWidht * 0.55,
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
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            )));
  }
}

class ButtonList extends StatelessWidget {
  const ButtonList({
    super.key,
    required this.mediaQueryWidht,
  });

  final double mediaQueryWidht;

  @override
  Widget build(BuildContext context) {
    AuthController ac = Get.find();

    return Positioned(
      bottom: ac.user.roleId == 2 ? 0 : 30,
      left: 8,
      right: 8,
      child: SizedBox(
          width: mediaQueryWidht,
          //color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_circle_rounded,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Detail Akun',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                            Icon(
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
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person_4_rounded,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Detail Perawat',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Icon(
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Edit Profil',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                            Icon(
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
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.app_registration,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Register Perawat',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Icon(
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
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.medical_services,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Layanan Homecare',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Icon(
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.bookmark,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Alamat Tersimpan',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_outlined,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () {
                    ac.logout();
                    Get.deleteAll();
                    Get.offAll(() => AuthView(), transition: Transition.fade);
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
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
