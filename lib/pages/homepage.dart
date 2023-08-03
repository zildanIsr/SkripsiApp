import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/auth.dart';
import 'package:flutter_application_1/Controllers/product_controller.dart';
import 'package:flutter_application_1/pages/listperawat_view.dart';
import 'package:flutter_application_1/pages/search_view.dart';
import 'package:flutter_application_1/widgets/perawat_card.dart';
import '../Models/kategori_model.dart';

import 'package:get/get.dart';

import '../widgets/skeleton.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    AuthController ac = Get.find();
    ProductController pc = Get.put(ProductController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            height: bodyHeight * 0.27,
            //color: Colors.blue,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(16, 50.0, 16.0, 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Selamat Datang',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    ac.user.name,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 1),
                        pageBuilder: (_, __, ___) => const SearchView(),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'search-bar',
                    child: Material(
                      color: Colors.transparent,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          hintText: 'cari nama perawat..',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search_outlined),
                          suffixIcon: Icon(
                            Icons.arrow_circle_right_rounded,
                            color: Colors.green.shade300,
                            size: 32,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                  color: Colors.black26, width: 0.5)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            //color: Colors.amber,
            height: bodyHeight * 0.23,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Sehat Dari Rumah',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CategoryList()
                ],
              ),
            ),
          ),
          SizedBox(
            height: bodyHeight * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                  child: Text(
                    'Perawat Terfavorit',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Obx(() => pc.isLoading.value
                    ? const CardSkeleton(
                        count: 1,
                      )
                    : pc.populerProduct.isEmpty
                        ? const Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: 100.0,
                                ),
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
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 16.0),
                            itemCount: pc.populerProduct.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return PerawatListItem(
                                key: ValueKey(pc.populerProduct[index].id),
                                thumbnail: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      pc.populerProduct[index].user.image,
                                      fit: BoxFit.fill,
                                    )),
                                name: pc.populerProduct[index].user.name,
                                category:
                                    pc.populerProduct[index].category.name,
                                price: pc.populerProduct[index].price,
                                rating: pc.populerProduct[index].nurse.rating
                                    .toDouble(),
                                strNumber:
                                    pc.populerProduct[index].nurse.strNumber,
                                categoryId: pc.populerProduct[index].categoryId,
                                productId: pc.populerProduct[index].id,
                              );
                            }))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  CategoryList({super.key});

  final List<Kategori> categories = kategoriList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: categories.isEmpty
                ? <Widget>[
                    const Text(
                      "Tidak ada",
                      style: TextStyle(color: Colors.grey),
                    )
                  ]
                : List.generate(
                    categories.length,
                    (index) => SelectCard(
                        key: ValueKey(categories[index].id),
                        category: categories[index]))));
  }
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.category}) : super(key: key);
  final Kategori category;

  @override
  Widget build(BuildContext context) {
    ProductController pc = Get.put(ProductController());

    return Container(
      constraints: const BoxConstraints(maxHeight: 90, maxWidth: 90),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                    splashColor: Colors.pinkAccent.withAlpha(30),
                    onTap: () {
                      pc.getAllProductList(category.id);
                      Get.to(() => const ListPerawatView(), arguments: {
                        'category-name': category.name,
                        'category-id': category.id
                      });
                    },
                    child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Icon(
                          category.icon,
                          size: 30,
                        )))),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            category.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
