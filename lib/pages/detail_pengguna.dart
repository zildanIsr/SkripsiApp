import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/skeleton.dart';
import 'package:get/get.dart';

import '../Controllers/user_controller.dart';

class DetailPengguna extends StatelessWidget {
  const DetailPengguna({super.key, this.id, this.getAddress});

  final int? id;
  final String? getAddress;

  @override
  Widget build(BuildContext context) {
    final myAppBar = AppBar(
      leading: Builder(builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(4.0)),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                alignment: Alignment.center,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
        );
      }),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );

    final bodyHeight = MediaQuery.of(context).size.height -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final mediaQueryWidht = MediaQuery.of(context).size.width;

    UserController uc = Get.put(UserController());

    uc.getDataUserbyId(id!);

    //uc.getDataUser(id);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: myAppBar,
      body: Obx(() => uc.isLoading.value
          ? const ProfilSkeleton()
          : ProfileDetail(
              bodyHeight: bodyHeight,
              mediaQueryWidht: mediaQueryWidht,
              getAddress: getAddress)),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  const ProfileDetail(
      {super.key,
      required this.bodyHeight,
      required this.mediaQueryWidht,
      this.getAddress});

  final double bodyHeight;
  final double mediaQueryWidht;
  final String? getAddress;

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.find<UserController>();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: bodyHeight * 0.45,
            width: mediaQueryWidht,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.greenAccent,
                Colors.green.shade400,
              ],
            )),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  left: 50,
                  right: 50,
                  top: 80,
                  child: Column(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.pinkAccent,
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
                        uc.userbyid.name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
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
                    left: 110,
                    right: 110,
                    child: Card(
                      elevation: 4.0,
                      child: Container(
                        //width: mediaQueryWidht * 0.3,
                        height: 90,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    uc.userbyid.orders.length.toString(),
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  const Text(
                                    'Jumlah Pesanan',
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
          const SizedBox(
            height: 50.0,
          ),
          DetailInformation(getAddress: getAddress),
        ],
      ),
    );
  }
}

//LowerDetail
class DetailInformation extends StatelessWidget {
  const DetailInformation({
    Key? key,
    this.getAddress,
  }) : super(key: key);

  final String? getAddress;

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.find<UserController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            'Informasi Umum',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //Data Pengguna
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Tanggal Lahir',
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    uc.userbyid.birthDate ?? '-',
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Jenis Kelamin',
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    uc.userbyid.sex == 1
                        ? "Pria"
                        : uc.userbyid.sex == 2
                            ? "Wanita"
                            : "-",
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //Data Pengguna
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Berat',
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '${uc.userbyid.weight ?? "-"} Kg',
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Tinggi',
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '${uc.userbyid.height ?? "-"} cm',
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 32.0,
          ),
          const Text(
            'Informasi Lainnya',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Nomor Telepon',
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                uc.userbyid.phoneNumber,
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(
            height: 24.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Alamat Rumah',
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                getAddress ?? uc.address.value,
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    required this.vheight,
    Key? key,
  }) : super(key: key);

  final double vheight;

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.green,
        height: vheight,
        padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 80,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Zildan Isrezkinurahman Hernawan',
              maxLines: 1,
              softWrap: true,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ));
  }
}
