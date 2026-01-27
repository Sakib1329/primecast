import 'package:get/get.dart';
import 'package:primecast/app/modules/home/view/navbar.dart';

class SubscriptionController extends GetxController {
  void startTrial() {
    // Navigate to payment or success
    Get.toNamed('/payment');
  }

  void skip() {
  Get.offAll(GoogleNavBarPage(),transition: Transition.rightToLeft);
  }
}