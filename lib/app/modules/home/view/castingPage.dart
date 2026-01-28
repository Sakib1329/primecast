import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/casting_controller.dart';

class CastDevicePage extends StatelessWidget {
  const CastDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CastController controller = Get.put(CastController());

    return Scaffold(
      backgroundColor: AppColor.deepForestGreen, // Ensure background matches
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: CircleAvatar(
            backgroundColor: AppColor.darkOverlay30,
            child: const BackButton(color: Colors.white),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cast to Device",
              style: AppTextStyles.arimoBold.copyWith(fontSize: 22.sp),
            ),
            Text(
              "Connected to Living Room TV",
              style: AppTextStyles.arimoRegular.copyWith(
                fontSize: 12.sp,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        // Inside CastDevicePage actions:
        actions: [
          Obx(() => GestureDetector(
            onTap: controller.isScanning.value
                ? null
                : () => controller.showScanningPopup(), // Updated trigger
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColor.brightGreen,
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: Text(
                "Scan",
                style: AppTextStyles.arimoBold.copyWith(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
              ),
            ),
          )),
          SizedBox(width: 16.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            _buildActiveConnectionCard(controller),
            SizedBox(height: 30.h),
            _buildDeviceSectionHeader(),
            SizedBox(height: 15.h),
            Obx(
              () => Column(
                children: [
                  _buildDeviceTile(
                    controller,
                    "Living Room TV",
                    "Living Room",
                    "Available",
                    Icons.monitor,
                    "living_room_1",
                  ),
                  _buildDeviceTile(
                    controller,
                    "Bedroom Smart TV",
                    "Bedroom",
                    "Available",
                    Icons.tv,
                    "bedroom_1",
                  ),
                  _buildDeviceTile(
                    controller,
                    "Kitchen Display",
                    "Kitchen",
                    "Available",
                    Icons.tablet_android,
                    "kitchen_1",
                  ),
                  _buildDeviceTile(
                    controller,
                    "Sound System",
                    "Living Room",
                    "Available",
                    Icons.speaker,
                    "audio_1",
                  ),
                  _buildDeviceTile(
                    controller,
                    "Dad's Phone",
                    "Guest Room",
                    "Busy",
                    Icons.smartphone,
                    "phone_1",
                  ),
                  _buildDeviceTile(
                    controller,
                    "Office Monitor",
                    "Home Office",
                    "Offline",
                    Icons.desktop_windows,
                    "office_1",
                    isOffline: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            _buildCastingTips(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveConnectionCard(CastController controller) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.greenWith30Percent, AppColor.deepForestGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.brightGreen.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.cast_connected,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Living Room TV",
                      style: AppTextStyles.arimoBold.copyWith(fontSize: 14.sp),
                    ),
                    Text(
                      "Living Room",
                      style: AppTextStyles.arimoRegular.copyWith(
                        color: Colors.white60,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.brightGreen.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: const Text("Disconnect"),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "NOW PLAYING",
                  style: AppTextStyles.arimoBold.copyWith(
                    fontSize: 10.sp,
                    color: Colors.white38,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "The Last Kingdom",
                  style: AppTextStyles.arimoBold.copyWith(fontSize: 16.sp),
                ),
                Text(
                  "S1 E1 • Pilot",
                  style: AppTextStyles.arimoRegular.copyWith(
                    color: Colors.white60,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Obx(
            () => Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColor.darkOverlay30,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.volume_up, color: Colors.white70, size: 20.sp),
                      SizedBox(width: 10.w),
                      Text(
                        "Volume",
                        style: AppTextStyles.arimoRegular.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${(controller.volume.value * 100).toInt()}%",
                        style: AppTextStyles.arimoBold,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(Get.context!).copyWith(
                      trackHeight: 6.h,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 0,
                      ), // Flat slider look
                    ),
                    child: Slider(
                      value: controller.volume.value,
                      activeColor: AppColor.brightGreen,
                      inactiveColor: Colors.white10,
                      onChanged: (v) => controller.updateVolume(v),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceTile(
    CastController controller,
    String name,
    String room,
    String status,
    IconData icon,
    String id, {
    bool isOffline = false,
  }) {
    bool isSelected = controller.selectedDeviceId.value == id;
    Color statusColor = status == "Available"
        ? AppColor.brightGreen
        : (status == "Busy" ? Colors.orange : Colors.white30);

    return GestureDetector(
      onTap: isOffline ? null : () => controller.selectDevice(id),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.brightGreen.withOpacity(0.05)
              : AppColor.darkOverlay30,
          borderRadius: BorderRadius.circular(18.r),
          border: isSelected
              ? Border.all(color: AppColor.brightGreen, width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.brightGreen.withOpacity(0.2)
                    : Colors.white10,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppColor.brightGreen
                    : (isOffline ? Colors.white24 : Colors.white),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.arimoBold.copyWith(
                          fontSize: 14.sp,
                          color: isOffline ? Colors.white38 : Colors.white,
                        ),
                      ),
                      if (status == "Available") ...[
                        SizedBox(width: 4.w),
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: const BoxDecoration(
                            color: AppColor.brightGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "$room",
                        style: AppTextStyles.arimoRegular.copyWith(
                          fontSize: 13.sp,
                          color: AppColor.coolGray,
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Text(
                        "• $status",
                        style: AppTextStyles.arimoRegular.copyWith(
                          fontSize: 13.sp,
                          color: isOffline ? Colors.white24 : statusColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColor.brightGreen)
            else if (isOffline)
              const Icon(Icons.signal_wifi_off, color: Colors.white24),
          ],
        ),
      ),
    );
  }

  Widget _buildCastingTips() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.wifi, color: AppColor.brightGreen, size: 18.sp),
              SizedBox(width: 10.w),
              Text(
                "Casting Tips",
                style: AppTextStyles.arimoBold.copyWith(fontSize: 15.sp),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          _tipText("Make sure devices are on the same Wi-Fi network"),
          _tipText("Some devices may need to be enabled for casting"),
          _tipText("Tap \"Scan\" to refresh the device list"),
        ],
      ),
    );
  }

  Widget _tipText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Text(
        "• $text",
        style: AppTextStyles.arimoRegular.copyWith(
          fontSize: 12.sp,
          color: AppColor.coolGray,
        ),
      ),
    );
  }

  Widget _buildDeviceSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Available Devices",
          style: AppTextStyles.arimoBold.copyWith(fontSize: 18.sp),
        ),
        Text(
          "4 found",
          style: AppTextStyles.arimoRegular.copyWith(
            fontSize: 12.sp,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }
}
