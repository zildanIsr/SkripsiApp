import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/selectednurse_view.dart';
import 'package:get/get.dart';

import '../Controllers/product_controller.dart';
import '../Controllers/search_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    SearchNurse shc = Get.put(SearchNurse());

    onSearchChanged(String query) {
      if (shc.debounce?.isActive ?? false) shc.debounce!.cancel();
      shc.debounce = Timer(const Duration(milliseconds: 500), () {
        shc.searchNursebyName(query);
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        leadingWidth: 45,
        leading: IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            shc.nameController.text = '';
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        actions: [
          IconButton.filled(
            onPressed: () {
              shc.nameController.text = '';
            },
            icon: const Icon(
              Icons.clear,
            ),
          ),
        ],
        title: Hero(
          tag: 'search-bar',
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: TextField(
                controller: shc.nameController,
                onChanged: onSearchChanged,
                showCursor: true,
                decoration: const InputDecoration(
                  hintText: 'cari nama perawat..',
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() => shc.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : shc.searchnurse.isEmpty
              ? const Center(child: Text('Tidak ditemukan'))
              : ListView.builder(
                  itemCount: shc.searchnurse.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ItemList(
                      key: ValueKey(shc.searchnurse[index].nurse.id),
                      name: shc.searchnurse[index].name,
                      image: shc.searchnurse[index].image,
                      str: shc.searchnurse[index].nurse.strNumber,
                      id: shc.searchnurse[index].nurse.id,
                    );
                  })),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList(
      {super.key,
      required this.name,
      required this.str,
      required this.image,
      required this.id});

  final String name;
  final String str;
  final dynamic image;
  final int id;

  @override
  Widget build(BuildContext context) {
    ProductController pc = Get.find();

    return InkWell(
      onTap: () {
        pc.productbyNurseId(id);
        Get.to(
            () => SelectedNurseView(
                  id: id,
                  name: name,
                ),
            transition: Transition.rightToLeft);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: image == null
              ? const AssetImage('assets/doctor.png') as ImageProvider<Object>?
              : NetworkImage(image, scale: 1.0),
        ),
        title: Text(name),
        subtitle: Text(str),
      ),
    );
  }
}
