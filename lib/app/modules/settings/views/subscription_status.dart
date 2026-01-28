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
                  style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.coolGray),textAlign: TextAlign.center,),
            ),
            SizedBox(height: 20.h,),
          ],
        ),
      ),
    );
  }

  Widget _buildActivePlanCard(Subscription2Controller controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        // Gradient matching the bright mint/green in the image
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.greenTeal,
          AppColor.greenSemi, // Lighter mint
          // Deeper green
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header: Plan Name and Active Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: SvgPicture.asset(ImageAssets.svg10,height: 20.sp,)
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.planName.value,
                        style: AppTextStyles.arimoBold.copyWith(color: Colors.white, fontSize: 20.sp),
                      ),
                      Text(
                        "\$14.99/month",
                        style: AppTextStyles.arimoMedium.copyWith(color: Colors.white.withOpacity(0.8), fontSize: 12.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    "Active",
                    style: AppTextStyles.arimoBold.copyWith(fontSize: 10.sp, color: Colors.white),
                  ),
                ),
              )
            ],
          ),

          SizedBox(height: 30.h),

          // 2. The Frosted Overlay Container for Billing
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Next Billing Date",
                      style: AppTextStyles.arimoMedium.copyWith(color: Colors.white.withOpacity(0.9), fontSize: 12.sp),
                    ),
                    Text(
                      controller.billingDate.value,
                      style: AppTextStyles.arimoBold.copyWith(color: Colors.white, fontSize: 14.sp),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    value: 0.4, // Matches the image progress
                    backgroundColor: Colors.white.withOpacity(0.2),
                    color: Colors.white,
                    minHeight: 8.h,
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${controller.daysRemaining.value} days remaining",
                    style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: Colors.white.withOpacity(0.8)),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 25.h),

          // 3. Feature Checklist
          _buildFeatureItem("4K Ultra HD streaming"),
          _buildFeatureItem("Watch on 4 devices simultaneously"),
          _buildFeatureItem("Unlimited downloads"),
          _buildFeatureItem("Ad-free experience"),
          _buildFeatureItem("Early access to new releases"),
          _buildFeatureItem("Dolby Atmos audio"),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(

        children: [
          Icon(Icons.check, color: Colors.white, size: 20.sp),
          SizedBox(width: 12.w),
          Text(
            feature,
            style: AppTextStyles.arimoRegular.copyWith(color: Colors.white, fontSize: 13.sp),
          ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: AppColor.brightGreen, size: 30.sp),
            SizedBox(height: 5.h),
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
                  Text(price, style: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray,fontSize: 14.sp)),
                ],
              ),
              OutlinedButton(
                onPressed: () => controller.switchPlan(title),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColor.brightGreen),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text("Switch", style: AppTextStyles.arimoBold.copyWith(color: AppColor.brightGreen,fontSize: 12.sp)),
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
                Text(f, style: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray, fontSize: 13.sp)),
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
          side: BorderSide(color: AppColor.redDark),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: Text("Cancel Subscription",
            style: AppTextStyles.arimoBold.copyWith(color: AppColor.redDark, fontSize: 16.sp),textAlign: TextAlign.center,),
      ),
    );
  }
}