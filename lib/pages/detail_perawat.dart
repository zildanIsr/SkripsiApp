import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/nurse_data.dart';
import '../widgets/skeleton.dart';
import '../widgets/workrate.dart';
import 'detail_rating_view.dart';

class DetailPerawat extends StatelessWidget {
  const DetailPerawat({super.key, required this.strNumber});

  final String strNumber;

  @override
  Widget build(BuildContext context) {
    NurseController nc = Get.find<NurseController>();
    nc.getNurseDatabySTR(strNumber);

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

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: myAppBar,
        body: Obx(
          () => nc.isLoading.value
              ? const ProfilSkeleton()
              : nc.isError.value
                  ? const Center(
                      child: Text(
                        'Perawat Tidak Ditemukan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ProfileDetail(
                      bodyHeight: bodyHeight,
                      mediaQueryWidht: mediaQueryWidht,
                      clinic: nc.singleNurse.workPlace,
                      dayOp: nc.singleNurse.dayActive,
                      education: nc.singleNurse.education,
                      name: nc.singleNurse.user!.name,
                      strNumber: nc.singleNurse.strNumber,
                      timeOp: nc.singleNurse.timeRange,
                      amountProduct: nc.singleNurse.products!.length.toString(),
                      amountOrder: nc.singleNurse.orders!.length.toString(),
                    ),
        ));
  }
}

class ProfileDetail extends StatelessWidget {
  const ProfileDetail(
      {super.key,
      required this.bodyHeight,
      required this.mediaQueryWidht,
      required this.name,
      required this.clinic,
      required this.strNumber,
      required this.dayOp,
      required this.timeOp,
      required this.education,
      required this.amountProduct,
      required this.amountOrder});

  final double bodyHeight;
  final double mediaQueryWidht;
  final String name;
  final String clinic;
  final String strNumber;
  final List dayOp;
  final List timeOp;
  final List education;
  final String amountProduct;
  final String amountOrder;

  @override
  Widget build(BuildContext context) {
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
                  top: 80,
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
                        name,
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
                    left: 50,
                    right: 50,
                    child: Card(
                      elevation: 4.0,
                      child: InkWell(
                        splashColor: Colors.pink.shade200,
                        onTap: () {
                          Get.to(() => const DetailRating());
                        },
                        child: Container(
                          width: mediaQueryWidht * 0.7,
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
                                    Text(
                                      amountProduct,
                                      style: const TextStyle(
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
                              // const VerticalDivider(
                              //   width: 1,
                              //   thickness: 1,
                              //   indent: 8,
                              //   endIndent: 8,
                              //   color: Colors.black26,
                              // ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    // Text(
                                    //   'Rating',
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //       fontSize: 16.0,
                                    //       color: Colors.black38,
                                    //       fontWeight: FontWeight.w500),
                                    // ),
                                    RatingNurse(
                                        sizeIcon: 20,
                                        alignSelected: MainAxisAlignment.center,
                                        rate: "4.8"),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      '  Rating',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    // Text(
                                    //   'Lihat Ulasan',
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //       color: Colors.pink,
                                    //       fontWeight: FontWeight.w500),
                                    // )
                                  ],
                                ),
                              ),
                              // const VerticalDivider(
                              //   width: 1,
                              //   thickness: 1,
                              //   indent: 8,
                              //   endIndent: 8,
                              //   color: Colors.black26,
                              // ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      amountOrder,
                                      style: const TextStyle(
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
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 60.0,
          ),
          OperasionalTime(
            dayOperasional: dayOp,
            timeOperasional: timeOp,
          ),
          const SizedBox(
            height: 18.0,
          ),
          const Divider(
            height: 6.0,
            thickness: 4.0,
          ),
          const SizedBox(
            height: 16.0,
          ),
          NurseDetailInformation(
            list: education,
            clinicName: clinic,
            str: strNumber,
          )
        ],
      ),
    );
  }
}

class NurseDetailInformation extends StatelessWidget {
  const NurseDetailInformation({
    super.key,
    required this.list,
    required this.clinicName,
    required this.str,
  });

  final List list;
  final String clinicName;
  final String str;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Informasi Perawat',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: const [
                        Icon(Icons.account_balance_rounded),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Riwayat Pendidikan',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: list.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 8.0),
                              child: Text(
                                  '${(index + 1).toString()}. ${list[index]}',
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400)),
                            );
                          }),
                    )
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.work_outline),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'Tempat Praktik',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(32.0, 8.0, 16.0, 0.0),
                          child: Text(
                            clinicName,
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        )
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.health_and_safety_outlined),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'Nomor STR',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(32.0, 8.0, 16.0, 16.0),
                          child: Text(
                            str,
                            softWrap: true,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ]),
    );
  }
}

class OperasionalTime extends StatelessWidget {
  const OperasionalTime({
    super.key,
    required this.dayOperasional,
    required this.timeOperasional,
  });

  final List dayOperasional;
  final List timeOperasional;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Layanan Operasional',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.date_range_rounded, color: Colors.green),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Hari Praktik',
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(
                          dayOperasional.length,
                          (index) => Text(
                                '${dayOperasional[index]}, ',
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              )),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Jam Praktik',
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Pukul ${timeOperasional[0]} - ${timeOperasional[1]}',
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
