import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:primecast/app/modules/settings/views/notification_settings.dart';

import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/notification_controller.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(

      appBar: AppBar(

        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notifications", style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp)),
            Text("2 unread", style: AppTextStyles.arimoRegular.copyWith(fontSize: 14.sp, color: AppColor.brightGreen)),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w, top: 12.h),
            child: OutlinedButton(
              onPressed: () => controller.markAllAsRead(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColor.brightGreen),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Text("Mark all as read",
                  style: AppTextStyles.arimoMedium.copyWith(fontSize: 12.sp, color: AppColor.brightGreen)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          Divider(color: AppColor.grayish,),
          _buildSettingsBar(),

          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) => _notificationTile(controller.notifications[index]),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsBar() {
    return GestureDetector(
      onTap: (){
        Get.to(NotificationSettingsPage(),transition: Transition.rightToLeft);
      },

      child: Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColor.darkOverlay30,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.settings_outlined, color: AppColor.pureWhite, size: 22.sp),
            SizedBox(width: 12.w),
            Text("Notification Settings", style: AppTextStyles.arimoMedium.copyWith(fontSize: 15.sp)),
            const Spacer(),
            CircleAvatar(radius: 4.r, backgroundColor: AppColor.brightGreen),
          ],
        ),
      ),
    );
  }

  Widget _notificationTile(NotificationModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: item.isRead ?AppColor.deepForestGreen:AppColor.darkOverlay30,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE WITH BADGE STACK
          _buildLeadingImage(item),

          SizedBox(width: 16.w),

          // TEXT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.title, style: AppTextStyles.arimoBold.copyWith(fontSize: 14.sp)),
                    if (!item.isRead)
                      CircleAvatar(radius: 4.r, backgroundColor: AppColor.brightGreen),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(item.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.coolGray)),
                SizedBox(height: 5.h),
                Text(item.time, style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.grayish)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingImage(NotificationModel item) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: item.imageUrl != null
              ? Image.asset(item.imageUrl!, height: 60.h, width: 60.w, fit: BoxFit.cover)
              : Container(
            height: 60.h, width: 60.w,
            color: AppColor.darkOverlay30,
            child: Icon(Icons.notifications, color: AppColor.brightGreen),
          ),
        ),
        // Mini Badge Icon (Top Right of Image)
        Positioned(
          top: 2,
          right: 2,
          child: Container(
            padding: EdgeInsets.all(2.w),
            decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
            child: _getSmallTypeIcon(item.type),
          ),
        ),
      ],
    );
  }

  Widget _getSmallTypeIcon(NotificationType type) {
    IconData icon;
    Color color;
    switch (type) {
      case NotificationType.episode: icon = Icons.tv; color = Colors.green; break;
      case NotificationType.download: icon = Icons.download_for_offline; color = Colors.blue; break;
      case NotificationType.offer: icon = Icons.card_giftcard; color = Colors.purple; break;
      case NotificationType.system: icon = Icons.star; color = Colors.amber; break;
    }
    return Icon(icon, color: color, size: 14.sp);
  }
}
