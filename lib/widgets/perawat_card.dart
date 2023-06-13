import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Controllers/nurse_data.dart';
import 'package:flutter_application_1/Controllers/order_form.dart';
import 'package:flutter_application_1/pages/detail_perawat.dart';
import 'package:flutter_application_1/widgets/workrate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.name,
    required this.category,
    required this.rating,
    required this.price,
    required this.strNumber,
    required this.categoryId,
    required this.productId,
  });

  final String name;
  final String category;
  final int categoryId;
  final double rating;
  final int price;
  final int productId;
  final String strNumber;

  @override
  Widget build(BuildContext context) {
    //final idr = NumberFormat("#.##0,00", "id_ID");

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
                fontSize: 20.0,
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
        Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RatingNurse(
                  alignSelected: MainAxisAlignment.start,
                  sizeIcon: 22.0,
                  rate: (rating).toStringAsFixed(1),
                ))),
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
                    fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  onPressed: () {
                    final oc = Get.put(OrderFormController());
                    Get.bottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15.0))),
                        backgroundColor: Colors.white,
                        Container(
                          height: 250,
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
                                height: 24.0,
                              ),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      maximumSize:
                                          const Size(110, double.infinity),
                                    ),
                                    onPressed: () {
                                      oc.onSubmit(strNumber, category,
                                          categoryId, price, productId);
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Lanjut',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                          Icon(
                                            Icons.navigate_next,
                                            size: 24.0,
                                          )
                                        ],
                                      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
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
          child: SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.0,
                  child: thumbnail,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: _ArticleDescription(
                      name: name,
                      category: category,
                      rating: rating,
                      price: price,
                      strNumber: strNumber,
                      categoryId: categoryId,
                      productId: productId,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
