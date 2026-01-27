import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  void startTrial() {
    // Navigate to payment or success
    Get.toNamed('/payment');
  }

  void skip() {
    Get.offAllNamed('/home');
  }
}