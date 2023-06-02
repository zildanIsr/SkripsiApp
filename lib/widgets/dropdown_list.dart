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
  ProductController pc = Get.find();
  final List<Kategori> categories = kategoriList;
  late int _selected;

  @override
  void initState() {
    _selected = categories[pc.selectedCategory.value - 1].id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: BoxDecoration(
          color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
      child: DropdownButton(
        isDense: true,
        hint: const Text("Pilih Kategori"),
        value: _selected,
        alignment: AlignmentDirectional.bottomCenter,
        items: categories.map((value) {
          return DropdownMenuItem(
            value: value.id,
            child: Text(value.name),
          );
        }).toList(),
        onChanged: (value) {
          print(value);
          setState(() {
            _selected = value as int;
            pc.onChangedSelectedCat(value);
          });
        },
      ),
    );
  }
}
