import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/product_controller.dart';
import 'package:flutter_application_1/widgets/status_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Controllers/category_controller.dart';
import '../Models/kategori_model.dart';
import 'dropdown_list.dart';

class ListLayananCard extends StatelessWidget {
  const ListLayananCard({
    super.key,
    required this.categoryId,
    required this.price,
    required this.status,
    required this.id,
  });

  final int categoryId;
  final int price;
  final int status;
  final int id;

  @override
  Widget build(BuildContext context) {
    CategoryController cc = Get.put(CategoryController());
    Kategori category = cc.getCategory(categoryId);
    ProductController pc = Get.find();

    showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Menghapus Layanan'),
              content: const Text('Apa kamu yakin menghapus layanan ini?'),
              actions: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.pink)),
                  onPressed: () {
                    pc.deleteProduct(id);
                    Navigator.of(context).pop(true);
                  },
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

    showDialogEdit() async {
      return await Get.defaultDialog(
          title: 'Edit Layanan',
          titlePadding: const EdgeInsets.only(top: 16.0),
          titleStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          confirm: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
                onPressed: () {
                  pc.editProduct(id);
                  Navigator.of(context).pop(true);
                },
                child: const Text('Simpan')),
          ),
          cancel: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.pink.shade400)),
                onPressed: () {
                  Get.back();
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child: Text('Batal'),
                )),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            //color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Pilih Kategori',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          DropdownKategori(),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Harga Layanan',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                decoration: const InputDecoration(
                                  isDense: true,
                                  prefixIcon: Text(" Rp  "),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  pc.setPrice(int.parse(value));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Keterangan',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Text('1. Batas layanan terdaftar sebanyak 5',
                    style: TextStyle(fontSize: 14)),
                const Text('2. Tidak dapat mendaftar kategori yang sama',
                    style: TextStyle(fontSize: 14)),
                const Text('3. Harga layanan sudah dengan jasa dan peralatan',
                    style: TextStyle(fontSize: 14))
              ],
            ),
          ));
    }

    return Container(
      //color: Colors.amber,
      width: MediaQuery.of(context).size.width,
      height: 190.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        //color: Colors.green,
        elevation: 4.0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.7,
              child: Container(
                //color: Colors.blue,
                alignment: Alignment.center,
                child: Icon(
                  category.icon,
                  size: 60,
                ),
              ),
            ),
            VerticalDivider(
              width: 2,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Colors.grey.shade200,
            ),
            Expanded(
                child: Container(
              //color: Colors.blue,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: "id-ID", decimalDigits: 0, name: 'Rp ')
                        .format(price),
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const StatusWidget(
                    sizeIcon: 20,
                    alignSelected: MainAxisAlignment.start,
                    iconType: Icons.info_outline,
                    status: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.pink.shade400)),
                          onPressed: () {
                            showExitPopup();
                          },
                          child: const Text('Hapus')),
                      const SizedBox(
                        width: 8.0,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            pc.selectedCategory.value = categoryId;
                            showDialogEdit();
                          },
                          child: const Text('Edit'))
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
