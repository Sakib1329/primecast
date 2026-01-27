import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController{

  final RxInt currentIndex = 0.obs;
  final pageController = PageController();
  void changePage(int index) {
    currentIndex.value = index;
  }
  @override
  void onInit() {
    super.onInit();
    currentIndex.listen((index) {
      pageController.jumpToPage(index);
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}