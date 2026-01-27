import 'package:get/get.dart';

class Subscription2Controller extends GetxController {
  // Current active plan details
  var planName = "Premium Plan".obs;
  var billingDate = "February 15, 2026".obs;
  var daysRemaining = 18.obs;
  var deviceCount = "2/4".obs;
  var downloadCount = "12".obs;

  void switchPlan(String newPlan) {
    // Logic to handle API call for switching plans
    Get.snackbar("Plan Updated", "You are switching to the $newPlan");
  }

  void cancelSubscription() {
    // Logic for cancellation
  }
}