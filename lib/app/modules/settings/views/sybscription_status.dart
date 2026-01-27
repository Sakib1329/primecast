import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:primecast/app/res/assets/asset.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/subscription2_controller.dart';


class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Subscription2Controller());

    return Scaffold(

      appBar: AppBar(

        elevation: 0,
        leading: BackButton(onPressed: Get.back, color: AppColor.pureWhite),
        title: Text("Subscription", style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActivePlanCard(controller),
            SizedBox(height: 20.h),
            _buildUsageStats(controller),
            SizedBox(height: 30.h),
            Text("OTHER PLANS",
                style: AppTextStyles.arimoBold.copyWith(fontSize: 14.sp, color: AppColor.grayish, letterSpacing: 1.2)),
            SizedBox(height: 15.h),
            _buildPlanOption("Basic", "\$8.99/month", ["HD streaming", "1 device", "Limited library", "With ads"], controller),
            SizedBox(height: 16.h),
            _buildPlanOption("Family", "\$19.99/month", ["Everything in Premium", "6 devices", "6 profiles", "Family sharing"], controller),
            SizedBox(height: 40.h),
            _buildCancelButton(),
            SizedBox(height: 20.h),
            Center(
              child: Text("Your subscription will remain active until ${controller.billingDate.value}",
                  style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.grayish)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivePlanCard(Subscription2Controller controller) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColor.brightGreen,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: SvgPicture.asset(ImageAssets.svg1)
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.planName.value, style: AppTextStyles.arimoBold.copyWith(color: Colors.black, fontSize: 22.sp)),
                      Text("\$14.99/month", style: AppTextStyles.arimoMedium.copyWith(color: Colors.black54, fontSize: 14.sp)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(20.r)),
                child: Text("Active", style: AppTextStyles.arimoBold.copyWith(fontSize: 12.sp, color: Colors.black)),
              )
            ],
          ),
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Next Billing Date", style: AppTextStyles.arimoMedium.copyWith(color: Colors.black54)),
              Text(controller.billingDate.value, style: AppTextStyles.arimoBold.copyWith(color: Colors.black)),
            ],
          ),
          SizedBox(height: 10.h),
          LinearProgressIndicator(
            value: 0.6,
            backgroundColor: Colors.black12,
            color: Colors.white,
            minHeight: 6.h,
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("${controller.daysRemaining.value} days remaining",
                style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: Colors.black54)),
          )
        ],
      ),
    );
  }

  Widget _buildUsageStats(Subscription2Controller controller) {
    return Row(
      children: [
        _statBox(Icons.people_outline, "Devices", controller.deviceCount.value),
        SizedBox(width: 15.w),
        _statBox(Icons.download_outlined, "Downloads", controller.downloadCount.value),
      ],
    );
  }

  Widget _statBox(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(color: AppColor.darkOverlay30, borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColor.brightGreen, size: 24.sp),
            SizedBox(height: 10.h),
            Text(label, style: AppTextStyles.arimoRegular.copyWith(color: AppColor.grayish, fontSize: 13.sp)),
            Text(value, style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanOption(String title, String price, List<String> features, Subscription2Controller controller) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(color: AppColor.darkOverlay30, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.arimoBold.copyWith(fontSize: 18.sp)),
                  Text(price, style: AppTextStyles.arimoRegular.copyWith(color: AppColor.grayish)),
                ],
              ),
              OutlinedButton(
                onPressed: () => controller.switchPlan(title),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColor.brightGreen),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text("Switch", style: AppTextStyles.arimoBold.copyWith(color: AppColor.brightGreen)),
              )
            ],
          ),
          Divider(color: Colors.white10, height: 30.h),
          ...features.map((f) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, size: 14.sp, color: AppColor.grayish),
                SizedBox(width: 8.w),
                Text(f, style: AppTextStyles.arimoRegular.copyWith(color: AppColor.grayish, fontSize: 13.sp)),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          side: BorderSide(color: AppColor.redDark.withOpacity(0.5)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: Text("Cancel Subscription",
            style: AppTextStyles.arimoBold.copyWith(color: AppColor.redSoft, fontSize: 16.sp)),
      ),
    );
  }
}