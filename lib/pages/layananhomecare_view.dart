import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/dropdown_list.dart';
import 'package:flutter_application_1/widgets/layanan_card.dart';
import 'package:flutter_application_1/widgets/skeleton.dart';
import 'package:get/get.dart';

import '../Controllers/product_controller.dart';

class LayananHomecareView extends StatelessWidget {
  const LayananHomecareView({super.key});

  @override
  Widget build(BuildContext context) {
    final pc = Get.find<ProductController>();

    final myAppbar = AppBar(
      title: const Text('Layanan Homecare'),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: 'Tambah Layanan',
                    titlePadding: const EdgeInsets.only(top: 16.0),
                    titleStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                    confirm: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                          onPressed: () {
                            pc.addNewProduct();
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Tambah')),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10.0),
                            child: Text('Batal'),
                          )),
                    ),
                    content: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 8.0),
                      //color: Colors.amber,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Pilih Kategori',
                                      style: TextStyle(
                                        fontSize: 16,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Text(
                                      'Harga Layanan',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            prefixIcon: Text(" Rp  "),
                                            prefixIconConstraints:
                                                BoxConstraints(
                                                    minWidth: 0, minHeight: 0),
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
                          const Text(
                              '2. Tidak dapat mendaftar kategori yang sama',
                              style: TextStyle(fontSize: 14)),
                          const Text(
                              '3. Harga layanan sudah dengan jasa dan peralatan',
                              style: TextStyle(fontSize: 14))
                        ],
                      ),
                    ));
              },
              icon: const Icon(Icons.add)),
        )
      ],
    );

    return Scaffold(
      appBar: myAppbar,
      body: Obx(() => pc.isLoading.value
          ? const CardSkeleton(
              count: 3,
            )
          : pc.myProduct.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada layanan yang terdaftar',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: pc.refreshData,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pc.myProduct.length,
                      itemBuilder: (context, index) {
                        return ListLayananCard(
                          key: ValueKey(pc.myProduct[index].id),
                          categoryId: pc.myProduct[index].categoryId,
                          price: pc.myProduct[index].price,
                          status: pc.myProduct[index].status,
                          id: pc.myProduct[index].id,
                        );
                      }),
                )),
    );
  }
}
