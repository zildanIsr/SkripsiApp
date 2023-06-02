import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/auth.dart';
import 'package:flutter_application_1/Controllers/order_form.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../Controllers/floatingbutton_con.dart';
import '../Controllers/nurse_data.dart';
import '../Controllers/orderconfirm_controller.dart';
import '../Models/costumerorder_model.dart';
import '../widgets/user_information.dart';
import '../widgets/scroll_hide_bottombar.dart';
import 'order_success.dart';

class DetailOrderView extends StatelessWidget {
  const DetailOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    var myAppbar = AppBar(
      title: const Text('Detail Pesanan'),
    );

    var mediaheight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaheight -
        myAppbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Keluar dari halaman'),
              content: const Text('Data pesanan anda tidak akan tersimpan?'),
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

    AuthController ac = Get.find();
    OrderFormController ofc = Get.find();
    NurseController nc = Get.put(NurseController());
    nc.getNurseDatabySTR(ofc.order.value.strNumber);

    FloatButtoncontroller bc = Get.put(FloatButtoncontroller());
    OrderConfirm oc = Get.put(OrderConfirm());

    createNewOrder(Order data) {
      //debugPrint('Name: ${data.name}, Password: ${data.password}');
      return Future.delayed(const Duration(seconds: 3)).then((_) async {
        var responses = await oc.addNewOrder(data);
        if (responses >= 400 && responses < 500) {
          return Get.snackbar("Error", "Gagal menambahkan pesanan",
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red.shade300);
        } else if (responses >= 500) {
          return Get.snackbar("Error", "Gagal menambahkan pesanan",
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red.shade300);
        } else if (responses >= 200) {
          Get.offAll(() => const OrderSuccessView());
        }
      });
    }

    return Scaffold(
      appBar: myAppbar,
      body: WillPopScope(
          onWillPop: showExitPopup,
          child: Obx(
            () => oc.isLoading.value
                ? Center(
                    child: LoadingAnimationWidget.waveDots(
                      color: Colors.pinkAccent,
                      size: 100,
                    ),
                  )
                : ListView(
                    shrinkWrap: true,
                    controller: bc.scrollController,
                    children: <Widget>[
                      //Perawat
                      UserInformation(
                        title1: 'Nomor STR',
                        title2: 'Telepon',
                        userName: nc.singleNurse.user!.name,
                        desc_1: nc.singleNurse.strNumber,
                        desc_2: nc.singleNurse.user!.phoneNumber,
                        bodyHeight: bodyHeight,
                        str: nc.singleNurse.strNumber,
                        nurse: true,
                      ),
                      const Divider(
                        height: 8,
                        thickness: 8,
                      ),
                      //Pasien
                      UserInformation(
                        title1: 'Telepon',
                        title2: '',
                        userName: ac.user.name,
                        desc_1: ac.user.phoneNumber,
                        desc_2: '',
                        bodyHeight: bodyHeight,
                        id: ac.user.id,
                        nurse: false,
                      ),
                      const Divider(
                        height: 8,
                        thickness: 8,
                      ),
                      //Detail Order
                      const OrderInformation(),
                      const Divider(
                        height: 8,
                        thickness: 8,
                      ),
                      const PriceDetail(),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
          )),
      bottomNavigationBar: ScrollHideBottomBar(
        controller: bc.scrollController,
        child: Container(
          height: 90,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: ElevatedButton(
              onPressed: () {
                createNewOrder(Order(
                    orderId: ofc.order.value.orderID,
                    productId: ofc.order.value.productId,
                    perawatId: nc.singleNurse.id!,
                    uAddressId: ofc.addressId.value,
                    totprice: ofc.order.value.totprice + 3000,
                    pacientAmount: ofc.order.value.amountPasient,
                    jadwalPesanan: ofc.order.value.dateTimePesanan,
                    updatedAt: DateTime.now(),
                    createdAt: DateTime.now()));
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'Pesan Sekarang',
                  style: TextStyle(fontSize: 16.0),
                ),
              )),
        ),
      ),
    );
  }
}

class PriceDetail extends StatelessWidget {
  const PriceDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrderFormController oc = Get.find<OrderFormController>();

    return Container(
      padding: const EdgeInsets.all(16.0),
      //color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detail Harga',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pembayaran',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'Tunai',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Jumlah Pasien',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                '${oc.amPacient} orang',
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Harga Jasa',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'Rp. ${oc.order.value.price}  x  ${oc.amPacient}',
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fee Transportasi',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'Rp. 3.000',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 14.0,
          ),
          const Divider(
            height: 2,
            thickness: 2,
            color: Colors.black38,
          ),
          const SizedBox(
            height: 14.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Biaya',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Rp. ${oc.order.value.totprice + 3000}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderFormController oc = Get.find<OrderFormController>();
    initializeDateFormatting();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Tittle
          Text(
            'Order ID ${oc.order.value.orderID.substring(0, 12)}',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(0.5),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Kategori',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    oc.order.value.categoryName,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Tanggal',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    DateFormat("EEE, MMM d y", 'in_ID')
                        .format(oc.order.value.dateTimePesanan),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Jam',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    DateFormat.Hm().format(oc.order.value.dateTimePesanan),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Alamat',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' : ',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    oc.stringaddress.value,
                    maxLines: 3,
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
