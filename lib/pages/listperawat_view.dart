import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/perawat_card.dart';

import 'package:get/get.dart';

class ListPerawatView extends StatelessWidget {
  const ListPerawatView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaWidht = MediaQuery.of(context).size.width;
    final myAppBar = AppBar (
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            onPressed: (){
              Get.back();
            }, 
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              )
          );
        }
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(
        Get.arguments,
        style: const TextStyle(
          color: Colors.black87,
        ),
        )
    );

    final bodyHeight = mediaQueryHeight - myAppBar.preferredSize.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: myAppBar,
      body: Container(
        height: bodyHeight,
        width: mediaWidht,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: const PerawatCard())
    );
  }
}