import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/product_controller.dart';
import 'package:flutter_application_1/widgets/perawat_card.dart';
import 'package:flutter_application_1/widgets/skeleton.dart';

import 'package:get/get.dart';

class ListPerawatView extends StatelessWidget {
  const ListPerawatView({super.key});

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
          Get.arguments['category-name'].toString(),
          style: const TextStyle(
            color: Colors.black87,
          ),
        ));

    ProductController pc = Get.find();

    return Scaffold(
        appBar: myAppBar,
        body: Obx(() => pc.isLoading.value
            ? const CardSkeleton(
                count: 3,
              )
            : pc.listProduct.isEmpty
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
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0),
                    shrinkWrap: true,
                    itemCount: pc.listProduct.length,
                    itemBuilder: (context, index) {
                      return PerawatListItem(
                        key: ValueKey(pc.listProduct[index].id),
                        thumbnail: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              pc.listProduct[index].user.image,
                              fit: BoxFit.fill,
                            )),
                        name: pc.listProduct[index].user.name,
                        category: pc.listProduct[index].category.name,
                        price: pc.listProduct[index].price,
                        rating: pc.listProduct[index].nurse.rating.toDouble(),
                        strNumber: pc.listProduct[index].nurse.strNumber,
                        categoryId: pc.listProduct[index].categoryId,
                        productId: pc.listProduct[index].id,
                      );
                    })));
  }
}
