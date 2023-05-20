import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/kategori_model.dart';

class CategoryController extends GetxController {
  var lc = kategoriList;

  String getNameCategory(int id) {
    var kategori = lc.where((e) => e.id == id);
    var datalist = kategori.toList();

    String name;
    datalist.isEmpty ? name = 'Kategori' : name = datalist[0].name;

    return name;
  }

  IconData getIconCategory(int id) {
    var kategori = lc.where((e) => e.id == id);
    var datalist = kategori.toList();

    IconData categoryIcon;
    datalist.isEmpty
        ? categoryIcon = Icons.medical_services_outlined
        : categoryIcon = datalist[0].icon;

    return categoryIcon;
  }

  getCategory(int id) {
    var kategori = lc.where((e) => e.id == id).toList();

    return kategori[0];
  }
}
