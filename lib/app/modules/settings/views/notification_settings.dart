import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/notification_controller.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationSettingsController());

    return Scaffold(

      appBar: AppBar(

        elevation: 0,
        leading: BackButton(onPressed: Get.back, color: AppColor.pureWhite),
        title: Text("Notification Settings",
            style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Master Control (Highlighted)
            Obx(() => _buildNotificationTile(
              title: "All Notifications",
              subtitle: "Master control",
              icon: Icons.notifications_none_rounded,
              value: controller.allNotifications.value,
              onChanged: (val) => controller.toggleAll(val),
              isMaster: true,
            )),

            SizedBox(height: 16.h),

            // Individual Settings
            _buildSection(controller),

            SizedBox(height: 30.h),

            // Info Box
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(NotificationSettingsController controller) {
    return Column(
      children: [
        Obx(() => _buildNotificationTile(
          title: "New Releases",
          subtitle: "Get notified about new shows and movies",
          icon: Icons.live_tv_rounded,
          value: controller.newReleases.value,
          onChanged: (val) => controller.newReleases.value = val,
        )),
        SizedBox(height: 16.h),
        Obx(() => _buildNotificationTile(
          title: "Downloads",
          subtitle: "Updates on your downloaded content",
          icon: Icons.file_download_outlined,
          value: controller.downloads.value,
          onChanged: (val) => controller.downloads.value = val,
        )),
        SizedBox(height: 16.h),
        Obx(() => _buildNotificationTile(
          title: "Recommendations",
          subtitle: "Personalized content suggestions",
          icon: Icons.star_border_rounded,
          value: controller.recommendations.value,
          onChanged: (val) => controller.recommendations.value = val,
        )),
        SizedBox(height: 16.h),
        Obx(() => _buildNotificationTile(
          title: "Promotions & Offers",
          subtitle: "Special deals and subscription offers",
          icon: Icons.card_giftcard_rounded,
          value: controller.promotions.value,
          onChanged: (val) => controller.promotions.value = val,
        )),
      ],
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isMaster = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(

        gradient: isMaster ?LinearGradient(
          colors: [
            AppColor.greenSemi,
            AppColor.greenTeal,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
        : LinearGradient(
      colors: [
      AppColor.darkOverlay30,
        AppColor.greenTeal,
        ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: isMaster ? Colors.white.withOpacity(0.2) : AppColor.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                color: isMaster ? AppColor.pureWhite : AppColor.brightGreen,
                size: 22.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.arimoBold.copyWith(
                        fontSize: 14.sp,
                        color: isMaster ? AppColor.pureWhite : AppColor.pureWhite)),
                Text(subtitle,
                    style: AppTextStyles.arimoRegular.copyWith(
                        fontSize: 12.sp,
                        color: isMaster ? AppColor.pureWhite : AppColor.coolGray)),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor:  AppColor.brightGreen,
            activeTrackColor:  isMaster ? AppColor.darkOverlay30 :AppColor.darkOverlay30,
            inactiveThumbColor: isMaster ? AppColor.pureWhite : AppColor.brightGreen.withOpacity(0.3),
            inactiveTrackColor: isMaster ? AppColor.darkOverlay30 : AppColor.darkOverlay30,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColor.darkOverlay30,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About Notifications",
              style: AppTextStyles.arimoBold.copyWith(fontSize: 18.sp, color: AppColor.pureWhite)),
          SizedBox(height: 12.h),
          Text(
            "Customize how you receive updates from PrimeCast. You can choose to receive notifications via push, email, or SMS for different types of updates.",
            style: AppTextStyles.arimoRegular.copyWith(color: AppColor.grayish, fontSize: 13.sp, height: 1.5),
          ),
          SizedBox(height: 12.h),
          Text(
            "Note: Some critical account notifications cannot be disabled for security reasons.",
            style: AppTextStyles.arimoRegular.copyWith(
                color: AppColor.grayish.withOpacity(0.6),
                fontSize: 12.sp,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}