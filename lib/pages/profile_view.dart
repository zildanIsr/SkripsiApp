import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/user_controller.dart';
import 'package:flutter_application_1/pages/auth_view.dart';
import 'package:flutter_application_1/pages/detail_pengguna.dart';
import 'package:get/get.dart';

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
                    color: Colors.green.shade300,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(150),
                        bottomRight: Radius.circular(150))),
              ),
            ),
            const Positioned(
              left: 50,
              right: 50,
              top: 110,
              child: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                radius: 80,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                    'assets/doctor.png',
                  ),
                  radius: 70,
                ),
              ),
            ),
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
        top: 270,
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
                            'PASIEN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.green.shade500,
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
      bottom: 0,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
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
                                        children: const [
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
                              children: const [
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
                                        children: const [
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
                                        children: const [
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
                              children: const [
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
                            const Icon(
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
                    Get.offAll(() => AuthView());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
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

//==========================================================================//
//Nurse Profile//

class NurseProfile extends StatelessWidget {
  const NurseProfile({
    super.key,
    required this.bodyHeight,
    required this.mediaQueryWidht,
  });

  final double bodyHeight;
  final double mediaQueryWidht;

  @override
  Widget build(BuildContext context) {
    AuthController ac = Get.find<AuthController>();
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        //color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: bodyHeight * 0.4,
              width: mediaQueryWidht,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.redAccent,
                  Colors.pink.shade400,
                ],
              )),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    left: 50,
                    right: 50,
                    top: 70,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          radius: 70,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              'assets/doctor.png',
                            ),
                            radius: 60,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          ac.user.name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: -50,
                      left: 100,
                      right: 100,
                      child: Card(
                        elevation: 4.0,
                        child: Container(
                          //width: mediaQueryWidht * 0.7,
                          //color: Colors.blue,
                          height: 90,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '9',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    const Text(
                                      'Layanan',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '1',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    const Text(
                                      'Pesanan',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              height: bodyHeight * 0.55,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              //color: Colors.blue,
              child: ButtonList(
                mediaQueryWidht: mediaQueryWidht,
              ),
            )
          ],
        ),
      ),
    );
  }
}
