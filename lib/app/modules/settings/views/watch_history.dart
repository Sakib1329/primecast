import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/watchhistory_controller.dart';

class WatchingHistoryScreen extends StatelessWidget {
  const WatchingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WatchHistoryController());

    return Scaffold(

      appBar: AppBar(

        elevation: 0,
        leading: BackButton(color: AppColor.pureWhite, onPressed: () => Get.back()),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Watching History", style: AppTextStyles.arimoBold.copyWith(fontSize: 18.sp)),
            Obx(() => Text("${controller.historyList.length} items",
                style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.grayish))),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => controller.clearAll(),
            child: Text("Clear All", style: AppTextStyles.arimoMedium.copyWith(color: AppColor.redSoft)),
          ),
        ],
      ),
      body: Obx(() => ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: controller.historyList.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final item = controller.historyList[index];
          return _buildHistoryCard(item, () => controller.removeItem(index));
        },
      )),
    );
  }

  Widget _buildHistoryCard(WatchItem item, VoidCallback onDelete) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.darkOverlay30,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Progress Bar
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  item.imageUrl,
                  width: 100.w,
                  height: 120.h,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(color: Colors.grey[900], child: const Icon(Icons.movie)),
                ),
              ),
              // Netflix-style Progress Bar
              Container(
                width: 100.w,
                height: 4.h,
                color: Colors.black.withOpacity(0.5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: item.progress,
                    child: Container(color: AppColor.brightGreen),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 10.h),
                  child: Text(item.title, style: AppTextStyles.arimoBold.copyWith(fontSize: 16.sp, color: AppColor.pureWhite)),
                ),
                Text(item.category, style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.coolGray)),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12.sp, color: AppColor.coolGray),
                    SizedBox(width: 4.w),
                    Text("${item.timeAgo}  •  ${item.seasonEpisode}",
                        style: AppTextStyles.arimoRegular.copyWith(fontSize: 11.sp, color: AppColor.coolGray)),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.isCompleted ? "Completed" : "${(item.progress * 100).toInt()}%",
                        style: AppTextStyles.arimoBold.copyWith(
                            fontSize: 12.sp,
                            color: item.isCompleted ? AppColor.brightGreen : AppColor.brightGreen
                        ),
                      ),
                    ),
                    Text(item.duration, style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.grayish)),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete_outline, color: AppColor.redDark, size: 20.sp),
          ),
        ],
      ),
    );
  }
}