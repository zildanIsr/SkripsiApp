import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/product_controller.dart';
import '../widgets/perawat_card.dart';
import '../widgets/skeleton.dart';

class SelectedNurseView extends StatelessWidget {
  const SelectedNurseView({super.key, required this.id, required this.name});

  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    final myAppBar = AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ));
        }),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.black87,
          ),
        ));

    ProductController pc = Get.find();

    return Scaffold(
        appBar: myAppBar,
        body: Obx(() => pc.isLoading.value
            ? const CardSkeleton(
                count: 4,
              )
            : pc.productNurse.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medical_services_outlined,
                          color: Colors.black12,
                          size: 100,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "Belum ada layanan",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0),
                    shrinkWrap: true,
                    itemCount: pc.productNurse.length,
                    itemBuilder: (context, index) {
                      return PerawatListItem(
                        key: ValueKey(pc.productNurse[index].id),
                        thumbnail: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              pc.productNurse[index].user.image,
                              fit: BoxFit.fitWidth,
                            )),
                        name: pc.productNurse[index].user.name,
                        category: pc.productNurse[index].category.name,
                        price: pc.productNurse[index].price,
                        rating: pc.productNurse[index].nurse.rating.toDouble(),
                        strNumber: pc.productNurse[index].nurse.strNumber,
                        categoryId: pc.productNurse[index].categoryId,
                        productId: pc.productNurse[index].id,
                      );
                    })));
  }
}
