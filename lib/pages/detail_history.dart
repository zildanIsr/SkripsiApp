import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../Controllers/address_controller.dart';
import '../Controllers/category_controller.dart';
import '../Controllers/detailhistory_controller.dart';
import '../Controllers/history_controller.dart';
import '../Controllers/report_controller.dart';
import '../Models/kategori_model.dart';
import '../widgets/user_information.dart';

class DetailHistory extends StatelessWidget {
  const DetailHistory({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    var myAppbar = AppBar(
      title: const Text('Detail Pesanan'),
    );

    var mediaheight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaheight -
        myAppbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    HistoryDetailController hc = Get.put(HistoryDetailController());

    hc.getDetailHistory(id!);

    return Scaffold(
      appBar: myAppbar,
      body: Obx(
        () => hc.isLoading.value
            ? Center(
                child: LoadingAnimationWidget.waveDots(
                  color: Colors.pinkAccent,
                  size: 100,
                ),
              )
            : hc.isError.value
                ? const Center(
                    child: Text('Error'),
                  )
                : DetailDataOrder(bodyHeight: bodyHeight),
      ),
    );
  }
}

class DetailDataOrder extends StatelessWidget {
  const DetailDataOrder({
    super.key,
    required this.bodyHeight,
  });

  final double bodyHeight;

  @override
  Widget build(BuildContext context) {
    HistoryDetailController hc = Get.find();
    HistoryContoller hcn = Get.find();
    AuthController ac = Get.find();
    ReportController rc = Get.put(ReportController());

    void popRate() {
      Get.bottomSheet(Container(
        width: MediaQuery.of(context).size.width,
        height: 270.0,
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Rating Layanan',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Berikan ulasan kamu pada layanan ini',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(
              height: 16.0,
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                hcn.rate.value = rating;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: hcn.descText,
                maxLines: 1,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                    onPressed: () {
                      hcn.sendRating(
                          hc.detailhistory.nurseId, hc.detailhistory.id);
                      hc.getDetailHistory(hc.detailhistory.id);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Kirim')))
          ],
        ),
      ));
    }

    void popReport() {
      Get.bottomSheet(Container(
        width: MediaQuery.of(context).size.width,
        height: 230.0,
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Laporkan Layanan',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Mengapa anda melaporkan layanan ini?',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                  return null;
                },
                controller: rc.descText,
                maxLines: 1,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                    onPressed: () {
                      rc.sendReport(
                          hc.detailhistory.nurseId, hc.detailhistory.id);
                      hc.getDetailHistory(hc.detailhistory.id);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Kirim')))
          ],
        ),
      ));
    }

    CategoryController cc = Get.put(CategoryController());
    Kategori category = cc.getCategory(hc.detailhistory.product.categoryId);

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        OrderInformation(
          kategoriname: category.name,
          iconCategory: category.icon,
          alamat:
              "${hc.detailhistory.address.street}, ${hc.detailhistory.address.sublocality}, ${hc.detailhistory.address.locality}, ${hc.detailhistory.address.subadminisArea}, ${hc.detailhistory.address.adminisArea} ${hc.detailhistory.address.postalCode}",
          harga: hc.detailhistory.totprice,
          pasien: hc.detailhistory.pacientAmount,
          statusorder: hc.detailhistory.status,
          dateTimeOrder: hc.detailhistory.jadwalPesanan,
          orderNumber: hc.detailhistory.orderId,
          isFinished: hc.detailhistory.isFinished,
          latitude: hc.detailhistory.address.latitude.toString(),
          longitude: hc.detailhistory.address.longitude.toString(),
          isDisplay: hc.detailhistory.userId == ac.user.id ? false : true,
        ),
        const Divider(
          height: 8,
          thickness: 8,
        ),
        //Perawat
        UserInformation(
          title1: 'Nomor STR',
          title2: 'Telepon',
          userName: hc.detailhistory.nurse.user.name,
          desc_1: hc.detailhistory.nurse.strNumber,
          desc_2: hc.detailhistory.nurse.user.phoneNumber,
          bodyHeight: bodyHeight,
          str: hc.detailhistory.nurse.strNumber,
          nurse: true,
          direct: true,
          image: hc.detailhistory.nurse.user.image,
        ),
        const Divider(
          height: 8,
          thickness: 8,
        ),
        //Pasien
        UserInformation(
          title1: '',
          title2: 'Telepon',
          userName: hc.detailhistory.user.name,
          desc_1: '',
          desc_2: hc.detailhistory.user.phoneNumber,
          bodyHeight: bodyHeight,
          id: hc.detailhistory.userId,
          nurse: false,
          getAddress:
              "${hc.detailhistory.address.street}, ${hc.detailhistory.address.sublocality}, ${hc.detailhistory.address.locality}, ${hc.detailhistory.address.subadminisArea}, ${hc.detailhistory.address.adminisArea} ${hc.detailhistory.address.postalCode}",
          direct: true,
          image: hc.detailhistory.user.image,
        ),
        const Divider(
          height: 4,
          thickness: 4,
        ),
        Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hc.detailhistory.userId == ac.user.id
                    ? hc.detailhistory.isFinished
                        ? ElevatedButton(
                            onPressed: () {
                              popReport();
                            },
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "Laporkan",
                                    ),
                                  ],
                                )),
                          )
                        : Container()
                    : Container(),
                const SizedBox(
                  width: 12.0,
                ),
                //hc.detailhistory.isFinished && !hc.detailhistory.isRated
                hc.detailhistory.userId == ac.user.id
                    ? hc.detailhistory.isFinished &&
                            hc.detailhistory.status == 1 &&
                            !hc.detailhistory.isRated
                        ? ElevatedButton(
                            onPressed: () {
                              popRate();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8.0),
                              child: Text(
                                "Berikan Ulasan",
                              ),
                            ),
                          )
                        : Container()
                    : Container(),
              ],
            ))
      ],
    );
  }
}

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    Key? key,
    required this.kategoriname,
    required this.alamat,
    required this.harga,
    required this.pasien,
    required this.statusorder,
    required this.orderNumber,
    required this.dateTimeOrder,
    required this.iconCategory,
    required this.isFinished,
    required this.latitude,
    required this.longitude,
    required this.isDisplay,
  }) : super(key: key);

  final String kategoriname;
  final String alamat;
  final int harga;
  final int pasien;
  final int statusorder;
  final String orderNumber;
  final DateTime dateTimeOrder;
  final IconData iconCategory;
  final bool isFinished, isDisplay;
  final String latitude, longitude;

  @override
  Widget build(BuildContext context) {
    AddressController ac = Get.put(AddressController());

    void directionMapUrl() {
      Get.bottomSheet(Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Buka Peta Untuk Arah',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Memulai arah dengan lokasi ini?',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                    onPressed: () {
                      //ac.getParmachiNearby(latitude, longitude);
                      ac.launchMapsUrl(alamat);
                    },
                    child: const Text('Mulai')))
          ],
        ),
      ));
    }

    initializeDateFormatting();
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Tittle
          Text(
            'Nomor Pesanan ${orderNumber.substring(0, 12)}',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(0.5),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Kategori',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        iconCategory,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        kategoriname,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Status',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        statusorder == 0
                            ? Icons.access_time
                            : statusorder == 1
                                ? Icons.check_circle_outline_outlined
                                : Icons.error_outline_outlined,
                        color: statusorder == 1
                            ? Colors.green
                            : statusorder == 2
                                ? Colors.red
                                : null,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        statusorder == 0
                            ? "Menunggu Konfirmasi"
                            : statusorder == 1 && isFinished
                                ? "Pesanan Selesai"
                                : "Sedang Berjalan",
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Hari',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    DateFormat("EEE, MMM d y", 'in_ID').format(dateTimeOrder),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Jam',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    DateFormat.Hm().format(dateTimeOrder),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Alamat',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alamat,
                        maxLines: 3,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          directionMapUrl();
                          //ac.launchMapsUrl(alamat);
                          // Clipboard.setData(ClipboardData(text: alamat));
                          // Get.snackbar('Alamat Tersalin', '',
                          //     colorText: Colors.black,
                          //     snackPosition: SnackPosition.BOTTOM,
                          //     snackStyle: SnackStyle.GROUNDED);
                        },
                        child: isDisplay
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Lihat Rute',
                                  style: TextStyle(
                                      color: Colors.blue.shade600,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Jumlah Pasien',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '$pasien pasien',
                    maxLines: 1,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Total Harga*',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    NumberFormat.currency(
                            locale: "id-ID", decimalDigits: 0, name: "Rp. ")
                        .format(harga),
                    maxLines: 1,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
