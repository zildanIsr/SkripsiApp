import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/controller.dart';
import 'package:flutter_application_1/pages/history_view.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/maps_view.dart';
import 'package:flutter_application_1/pages/profile_view.dart';

import 'package:get/get.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final controller = Get.put(NavbarController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(builder: (context) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex,
          children: const [
            Homepage(),
            HistoryView(),
            MapsView(),
            ProfileView()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 28,
          elevation: 10,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey.shade300,
          currentIndex: controller.tabIndex,
          showUnselectedLabels: true,
          onTap: controller.changeTabIndex,
          items: [
            _bottombarItem(Icons.home_filled, 'Home'),
            _bottombarItem(Icons.history, 'Riwayat'),
            _bottombarItem(Icons.map, 'Maps'),
            _bottombarItem(Icons.person, 'Profile'),
          ],
        ),
      );
    });
  }
}

// ignore: unused_element
_bottombarItem(IconData icon, String label){
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}