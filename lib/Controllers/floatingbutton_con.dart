import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class FloatButtoncontroller extends GetxController {
  var showButton = true.obs;
  late ScrollController scrollController;

  @override
  void onInit() {
    scrollController = ScrollController();

    super.onInit();
  }

  @override
  void dispose() {
    showButton.close();
    scrollController.dispose();
    super.dispose();
  }
}
