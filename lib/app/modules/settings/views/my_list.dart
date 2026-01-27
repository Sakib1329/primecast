import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/mylistcontroller.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(MyListController());

    return Scaffold(

      appBar: AppBar(

        elevation: 0,
        leading: BackButton(
          onPressed: Get.back,
          color: AppColor.coolGray,
        ),
        title: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My List", style: AppTextStyles.arimoBold.copyWith(fontSize: 24.sp)),
            Text("${controller.filteredItems.length} items saved",
                style: AppTextStyles.arimoRegular.copyWith(fontSize: 14.sp, color: AppColor.grayish)),
          ],
        )),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: _buildTabBar(controller),
        ),
      ),
      body: Obx(() {
        if (controller.filteredItems.isEmpty) {
          return Center(
            child: Text("No items found", style: AppTextStyles.arimoMedium.copyWith(color: AppColor.coolGray)),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(15.w),
          itemCount: controller.filteredItems.length,
          itemBuilder: (context, index) {
            final item = controller.filteredItems[index];
            // Pass context here
            return _buildMediaCard(context, item, controller);
          },
        );
      }),
    );
  }

  Widget _buildTabBar(MyListController controller) {
    final tabs = ["All", "Movies", "Series"];
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tabs.length,
          itemBuilder: (context, index) {
            return Obx(() {
              bool isSelected = controller.selectedTabIndex.value == index;
              return GestureDetector(
                onTap: () => controller.selectedTabIndex.value = index,
                child: Container(
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.brightGreen : AppColor.darkOverlay30,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      tabs[index],
                      style: AppTextStyles.arimoMedium.copyWith(
                        fontSize: 14.sp,
                        color: isSelected ? AppColor.black : AppColor.pureWhite,
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildMediaCard(BuildContext context, MediaItem item, MyListController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColor.darkOverlay30,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(item.imageUrl, width: 100.w, height: 130.h, fit: BoxFit.cover),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.r),
                  child: Text(item.title, style: AppTextStyles.arimoBold.copyWith(fontSize: 16.sp)),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text("${item.year}  •  ${item.info}  •  ",
                        style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.grayish)),
                    _buildTypeTag(item.type),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(item.genre, style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.grayish)),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.addedDate, style: AppTextStyles.arimoRegular.copyWith(fontSize: 11.sp, color: AppColor.grayish)),
                    Padding(
                      padding: EdgeInsets.only(right: 10.r),
                      child: Row(
                        children: [
                          _actionBtn(Icons.info_outline, () {}),
                          SizedBox(width: 8.w),
                          _actionBtn(
                            Icons.delete_outline,
                                () => _showDeleteConfirmation(context, controller, item),
                            isDelete: true,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, MyListController controller, MediaItem item) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColor.deepForestGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: AppColor.darkOverlay30,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColor.darkOverlay30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColor.redDark,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.delete_sweep_rounded, color: AppColor.pureWhite, size: 40.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Remove from List?",
                style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 12.h),
              Text(
                "Are you sure you want to remove '${item.title}' from your saved items?",
                textAlign: TextAlign.center,
                style: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray, fontSize: 14.sp),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text("Cancel",
                          style: AppTextStyles.arimoMedium.copyWith(color: AppColor.coolGray)),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.redDark,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      onPressed: () {
                        controller.removeItem(item);
                        Get.back(); // Close dialog
                        Get.snackbar(
                          "Removed",
                          "${item.title} has been removed",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColor.darkOverlay30,
                          colorText: AppColor.pureWhite,
                          margin: EdgeInsets.all(15),
                        );
                      },
                      child: Text("Remove",
                          style: AppTextStyles.arimoBold.copyWith(fontSize: 14.sp, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeTag(String type) => Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
    decoration: BoxDecoration(color: AppColor.brightGreen, borderRadius: BorderRadius.circular(4.r)),
    child: Text(type, style: AppTextStyles.arimoMedium.copyWith(fontSize: 10.sp, color: AppColor.black)),
  );

  Widget _actionBtn(IconData icon, VoidCallback onTap, {bool isDelete = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColor.black,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: isDelete ? AppColor.redDark.withOpacity(0.5) : AppColor.coolGray.withOpacity(0.2)),
        ),
        child: Icon(icon, size: 18.sp, color: isDelete ? AppColor.redSoft : AppColor.pureWhite),
      ),
    );
  }
}