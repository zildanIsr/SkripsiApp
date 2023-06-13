import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/category_controller.dart';
import 'package:flutter_application_1/Controllers/history_controller.dart';
import 'package:flutter_application_1/Models/kategori_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Controllers/auth.dart';
import '../pages/detail_history.dart';

class ItemHistoryPasien extends StatelessWidget {
  const ItemHistoryPasien(
      {super.key,
      required this.orderNumber,
      required this.amountPrice,
      required this.statusOrder,
      required this.userId,
      required this.categoryId,
      required this.isFinished,
      required this.id,
      required this.isRated,
      required this.perawatId});

  final int id;
  final String orderNumber;
  final int amountPrice;
  final int statusOrder;
  final int userId;
  final int categoryId;
  final int perawatId;
  final bool isFinished;
  final bool isRated;

  @override
  Widget build(BuildContext context) {
    HistoryContoller hc = Get.find();
    AuthController ac = Get.find();

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
                hc.rate.value = rating;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: hc.descText,
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
                      hc.sendRating(perawatId, id);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Kirim')))
          ],
        ),
      ));
    }

    CategoryController cc = Get.put(CategoryController());
    Kategori category = cc.getCategory(categoryId);

    return Container(
      //color: Colors.amber,
      constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          maxHeight: 225,
          minHeight: 180),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        //color: Colors.green,
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: InkWell(
          onTap: () {
            Get.to(
              () => DetailHistory(
                id: id,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              StatusOrder(
                status: statusOrder,
              ),
              const SizedBox(
                height: 2.0,
              ),
              const Divider(
                height: 1.0,
                thickness: 1,
              ),
              const SizedBox(
                height: 2.0,
              ),
              Container(
                //color: Colors.amber,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Nomor Pesanan',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          orderNumber.substring(0, 20),
                          overflow: TextOverflow.clip,
                          softWrap: false,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 1.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kategori : ',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Icon(
                          category.icon,
                          size: 22.0,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          category.name,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Harga : ',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          NumberFormat.currency(
                                  locale: "id-ID",
                                  decimalDigits: 0,
                                  name: 'Rp ')
                              .format(amountPrice),
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    userId == ac.user.id
                        ? isFinished && !isRated && statusOrder == 1
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  ElevatedButton(
                                      onPressed: () {
                                        popRate();
                                      },
                                      child: const Text('Ulasan'))
                                ],
                              )
                            : isFinished && isRated
                                ? Container()
                                : isFinished && statusOrder != 1
                                    ? Container()
                                    : ButtonOrder(
                                        userId: userId,
                                        status: statusOrder,
                                        id: id,
                                      )
                        : ButtonOrder(
                            userId: userId,
                            status: statusOrder,
                            id: id,
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonOrder extends StatelessWidget {
  const ButtonOrder({
    super.key,
    required this.userId,
    required this.status,
    required this.id,
  });

  final int userId;
  final int status;
  final int id;

  @override
  Widget build(BuildContext context) {
    AuthController ac = Get.find();
    HistoryContoller hc = Get.find();

    return userId == ac.user.id
        ? status == 1 || status == 2
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        hc.orderFinished(id);
                      },
                      child: const Text('Selesai'))
                ],
              )
            : Container()
        : status == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.pink.shade400)),
                      onPressed: () {
                        hc.acceptedOrder(id, 2);
                      },
                      child: const Text('Tolak')),
                  const SizedBox(
                    width: 8.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        hc.acceptedOrder(id, 1);
                      },
                      child: const Text('Terima'))
                ],
              )
            : Container();
  }
}

class StatusOrder extends StatelessWidget {
  const StatusOrder({
    super.key,
    required this.status,
  });

  final int status;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            status == 0
                ? Icons.access_time_rounded
                : status == 1
                    ? Icons.check_circle_outline_outlined
                    : Icons.error_outline_outlined,
            size: 28.0,
            color: status == 1
                ? Colors.green
                : status == 2
                    ? Colors.red
                    : null,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            status == 0
                ? "Menunggu konfirmasi"
                : status == 1
                    ? "Pesanan Disetujui"
                    : 'Pesanan Ditolak',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
