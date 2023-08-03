import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Controllers/nurse_data.dart';
//import 'package:flutter_application_1/Controllers/order_form.dart';
import 'package:flutter_application_1/pages/detail_perawat.dart';
import 'package:flutter_application_1/widgets/workrate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Controllers/orderconfirm_controller.dart';

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.name,
    required this.category,
    required this.rating,
    required this.price,
    required this.strNumber,
    required this.categoryId,
    required this.productId,
    required this.bodyheight,
  });

  final String name;
  final String category;
  final int categoryId;
  final double rating;
  final int price;
  final int productId;
  final String strNumber;
  final double bodyheight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 4.0)),
            Text(
              category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        RatingNurse(
          alignSelected: MainAxisAlignment.start,
          sizeIcon: 22.0,
          rate: (rating).toStringAsFixed(1),
          mb: bodyheight >= 700 ? 16 : 8,
          mt: bodyheight >= 700 ? 4 : 2,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                NumberFormat.currency(
                        locale: "id-ID", decimalDigits: 0, name: 'Rp ')
                    .format(price),
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  onPressed: () {
                    OrderConfirm oc = Get.put(OrderConfirm());

                    Get.bottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15.0))),
                        backgroundColor: Colors.white,
                        Container(
                          height: MediaQuery.of(context).size.height * 0.32,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 28.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //Tittle
                              const Text(
                                'Isi Data Pesanan',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                children: <Widget>[
                                  //Date Pick
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.36,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Pilih Tanggal',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          TextFormField(
                                              controller: oc.dtTextField,
                                              autofocus: true,
                                              decoration: const InputDecoration(
                                                prefixIcon:
                                                    Icon(Icons.calendar_today),
                                                hintText: 'Tanggal',
                                                border: OutlineInputBorder(),
                                                isDense: true,
                                              ),
                                              readOnly: true,
                                              onTap: (() async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2100),
                                                );
                                                if (pickedDate != null) {
                                                  String formattedDate =
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(pickedDate);
                                                  oc.dtTextField.text =
                                                      formattedDate;
                                                  oc.dateOrderChanged(
                                                      pickedDate);
                                                }
                                              })),
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  //Time picker
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.27,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Pilih Waktu',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          TextFormField(
                                              controller: oc.tmTextField,
                                              autofocus: true,
                                              decoration: const InputDecoration(
                                                prefixIcon: Icon(
                                                    Icons.timelapse_outlined),
                                                hintText: 'Waktu',
                                                border: OutlineInputBorder(),
                                                isDense: true,
                                              ),
                                              readOnly: true,
                                              onTap: (() async {
                                                TimeOfDay? pickedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                  builder: (context, child) {
                                                    return MediaQuery(
                                                      data: MediaQuery.of(
                                                              context)
                                                          .copyWith(
                                                              alwaysUse24HourFormat:
                                                                  true),
                                                      child:
                                                          child ?? Container(),
                                                    );
                                                  },
                                                );
                                                if (pickedTime != null) {
                                                  String formattedTime =
                                                      DateFormat.Hm().format(
                                                          DateTime(
                                                              oc.dateOrder.value
                                                                  .year,
                                                              oc.dateOrder.value
                                                                  .month,
                                                              oc.dateOrder.value
                                                                  .day,
                                                              pickedTime.hour,
                                                              pickedTime
                                                                  .minute));
                                                  oc.tmTextField.text =
                                                      formattedTime;
                                                  oc.timeOrderChanged(
                                                      pickedTime);
                                                }
                                              })),
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.22,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Pasien',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          TextFormField(
                                            controller: oc.pacientTextField,
                                            autofocus: true,
                                            validator: (value) {
                                              if (value == '0') {
                                                return 'Tidak boleh 0';
                                              }
                                              return null;
                                            },
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ],
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.person),
                                              hintText: '1',
                                              border: OutlineInputBorder(),
                                              isDense: true,
                                            ),
                                            onChanged: (val) {
                                              oc.amPacient.value =
                                                  int.parse(val);
                                            },
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      maximumSize:
                                          const Size(110, double.infinity),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      oc.onOrder(strNumber, category,
                                          categoryId, price, productId);
                                    },
                                    child: const Text(
                                      'Lanjut',
                                      style: TextStyle(fontSize: 14.0),
                                    )),
                              )
                            ],
                          ),
                        ),
                        isScrollControlled: true);
                  },
                  child: const Text('Pesan'))
            ],
          ),
        )
      ],
    );
  }
}

class PerawatListItem extends StatelessWidget {
  const PerawatListItem({
    super.key,
    required this.thumbnail,
    required this.name,
    required this.category,
    required this.rating,
    required this.price,
    required this.strNumber,
    required this.categoryId,
    required this.productId,
  });

  final Widget thumbnail;
  final String name;
  final String category;
  final double rating;
  final int price;
  final int categoryId;
  final String strNumber;
  final int productId;

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      return Card(
        color: Colors.white12,
        elevation: 0.0,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: (() {
            Get.to(
                () => DetailPerawat(
                      strNumber: strNumber,
                    ), binding: BindingsBuilder(() {
              Get.put(NurseController());
            }));
          }),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: bodyHeight >= 700 ? 145 : 120,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            //color: Colors.amber,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  //color: Colors.amber,
                  height: bodyHeight >= 700 ? 130 : 100,
                  width: bodyHeight >= 700 ? 130 : 100,
                  child: Container(child: thumbnail),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 2.0, 0.0),
                    child: _ArticleDescription(
                      name: name,
                      category: category,
                      rating: rating,
                      price: price,
                      strNumber: strNumber,
                      categoryId: categoryId,
                      productId: productId,
                      bodyheight: bodyHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
