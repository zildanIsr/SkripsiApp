import 'package:flutter/material.dart';

class Kategori {
  final int id;
  final IconData icon;
  final String name;

  Kategori(this.id, this.icon, this.name);
}

List<Kategori> kategoriList = <Kategori>[
  Kategori(
    1,
    Icons.local_hospital_outlined,
    'Infusisasi',
  ),
  Kategori(
    2,
    Icons.hotel_sharp,
    'Rawat Jalan',
  ),
  Kategori(3, Icons.health_and_safety_outlined, 'Tensi'),
  Kategori(4, Icons.healing, 'Rawat Luka'),
  Kategori(5, Icons.elderly, 'Lansia'),
  Kategori(6, Icons.female, 'Ibu Anak'),
];
