import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/kategori_model.dart';
import 'package:get/get.dart';

import '../Controllers/product_controller.dart';

class DropdownKategori extends StatefulWidget {
  const DropdownKategori({super.key});

  @override
  State<DropdownKategori> createState() => _DropdownKategoriState();
}

class _DropdownKategoriState extends State<DropdownKategori> {
  ProductController pc = Get.put(ProductController());
  final List<Kategori> categories = kategoriList;
  late Kategori selectedCategory;

  @override
  void initState() {
    selectedCategory = categories.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 12, 12, 8),
      decoration: BoxDecoration(
          color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
      child: DropdownButton(
        isDense: true,
        hint: const Text("Pilih Kategori"),
        value: selectedCategory,
        alignment: AlignmentDirectional.bottomCenter,
        items: categories.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCategory = value as Kategori;
            pc.onChangedSelectedCat(value.id);
          });
        },
      ),
    );
  }
}
