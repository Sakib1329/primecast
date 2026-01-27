import 'package:get/get.dart';

class NotificationSettingsController extends GetxController {
  // Observable boolean values for the switches
  var allNotifications = true.obs;
  var newReleases = true.obs;
  var downloads = false.obs;
  var recommendations = true.obs;
  var promotions = false.obs;

  void toggleAll(bool value) {
    allNotifications.value = value;
    // Optionally toggle others based on master control
    newReleases.value = value;
    recommendations.value = value;
  }
}