import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/product_controller.dart';
import 'package:flutter_application_1/pages/listperawat_view.dart';
import 'package:flutter_application_1/widgets/perawat_card.dart';
import '../Models/kategori_model.dart';

import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    //final mediaQueryWidht = MediaQuery.of(context).size.width;

    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: bodyHeight * 0.2,
            //color: Colors.amber,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(16, 50.0, 16.0, 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Text(
                  'Selamat Datang',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 4.0,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    'Nama Penggunaa aaaaa',
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            //color: Colors.amber,
            height: bodyHeight * 0.25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Flexible(
                      child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Sehat Dari Rumah',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  )),
                  Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CategoryList(),
                      ))
                ],
              ),
            ),
          ),
          Container(
            height: bodyHeight * 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Layanan Terbaru',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(child: PerawatCard())
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
      constraints: const BoxConstraints(maxHeight: 100, maxWidth: 100),
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(right: 4),
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
                          size: 40,
                        )))),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            category.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
