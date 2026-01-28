import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart'; // Import the lottie package
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';

class CastController extends GetxController {
  var isScanning = false.obs;
  var volume = 0.75.obs;
  var selectedDeviceId = "living_room_1".obs;

  void showScanningPopup() {
    isScanning.value = true;

    Get.dialog(
      barrierDismissible: false,
      Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 30.w),
          decoration: BoxDecoration(
            color: const Color(0xFF18181B), // Matches image_98ba37.png
            borderRadius: BorderRadius.circular(28.r),
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Lottie.asset(
                  'assets/animations/wifi_connect.json',
                  width: 120.w,
                  height: 120.h,
                  fit: BoxFit.contain,


                ),
                SizedBox(height: 20.h),
                Text(
                  "Scanning for devices...",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.arimoBold.copyWith(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Looking for available devices nearby",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.arimoRegular.copyWith(
                    color: Colors.white38,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Simulate scan delay
    Future.delayed(const Duration(seconds: 4), () {
      isScanning.value = false;
      if (Get.isDialogOpen ?? false) Get.back();

      Get.snackbar(
        "Scan Complete",
        "4 available devices found near you.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.darkOverlay30,
        colorText: Colors.white,
      );
    });
  }

  void updateVolume(double value) => volume.value = value;
  void selectDevice(String id) => selectedDeviceId.value = id;
}