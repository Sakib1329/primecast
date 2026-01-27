import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../res/assets/asset.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart'; // Ensure this matches your AppTextStyles path
import '../../../widgets/custom_button.dart';
import '../controllers/subscription_controller.dart';

class PremiumSubscriptionPage extends StatelessWidget {
  const PremiumSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: AppColor.black,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.black, AppColor.black],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              // --- LOGO ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.svg1, height: 30.h),
                  SizedBox(width: 10.w),
                  Text("PrimeCast",
                      style: AppTextStyles.arimoBold.copyWith(fontSize: 25.sp)),
                ],
              ),
              SizedBox(height: 10.h),
              _buildBadge("LIMITED TIME OFFER", AppColor.redDark),
              SizedBox(height: 30.h),
              // --- PRICING CARD ---
              _buildPricingCard(controller),

              SizedBox(height: 30.h),

              // --- BENEFITS SECTION ---
              _buildBenefitsSection(),

              SizedBox(height: 30.h),

              // --- ACTIONS ---
              GestureDetector(
                onTap: controller.skip,
                child: Text("Skip for now",
                    style: AppTextStyles.arimoRegular.copyWith(
                        color: AppColor.coolGray,
                        fontSize: 16.sp
                    )),
              ),

              SizedBox(height: 20.h),

              Text(
                "Your subscription will automatically renew at \$3.99/month after the first month unless you cancel. You can cancel anytime in your account settings.",
                textAlign: TextAlign.center,
                style: AppTextStyles.arimoRegular.copyWith(
                    color: AppColor.grayish,
                    fontSize: 11.sp
                ),
              ),

              SizedBox(height: 10.h),

              _buildFooterLinks(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCard(SubscriptionController controller) {
    return Stack(
      clipBehavior: Clip.none, // 👈 allow overlap
      children: [

        // 🔥 Main card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: AppColor.black,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColor.redBright30, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColor.redDark,
                blurRadius: 20,
                spreadRadius: 5,
              )
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              Text(
                "\$3.99",
                style: AppTextStyles.arimoRegular.copyWith(
                  color: AppColor.coolGray,
                  fontSize: 18.sp,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColor.coolGray
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Text("\$", style: AppTextStyles.arimoBold.copyWith(fontSize: 40.sp)),
                  ),
                  SizedBox(width: 5.w,),
                  Text("0", style: AppTextStyles.arimoBold.copyWith(fontSize: 80.sp)),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Text(".99", style: AppTextStyles.arimoBold.copyWith(fontSize: 40.sp)),
                  ),
                ],
              ),

              Text(
                "for your first month",
                style: AppTextStyles.arimoMedium.copyWith(fontSize: 16.sp,color: AppColor.coolGray),
              ),

              SizedBox(height: 15.h),
              _buildPromoTag("Save 75% • Then \$3.99/mo"),

              SizedBox(height: 30.h),

              CustomButton(
                title: "Start Your Premium Trial",
                onPress: () async => controller.startTrial(),
                buttonColor: AppColor.redBright,
                borderColor: AppColor.redBright,
                borderShadowColor: AppColor.redBright,
                textColor: Colors.white,
                leadingSvg: true,
                leadingSvgPath: ImageAssets.svg10,
                imageHeight: 12.h,
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _infoRow(Icons.security, "Secure Payment"),
                  SizedBox(width: 15.w),
                  _infoRow(Icons.check, "Cancel Anytime"),
                ],
              ),
            ],
          ),
        ),

        // 🏷️ Badge (TOP CENTER)
        Positioned(
          top: -14.h,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: _buildBadge("PREMIUM ACCESS", AppColor.redDark),
          ),
        ),
      ],
    );
  }


  Widget _buildBenefitsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.darkOverlay30,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.grayish)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Everything You Get",
              style: AppTextStyles.arimoBold.copyWith(fontSize: 18.sp)),
          SizedBox(height: 20.h),
          _benefitItem(ImageAssets.svg2, "Unlimited streaming in 4K Ultra HD"),
          _benefitItem(ImageAssets.svg11, "Watch on any device, anywhere"),
          _benefitItem(ImageAssets.svg3, "Download and watch offline"),
          _benefitItem(ImageAssets.svg5, "Exclusive originals & early access"),
          _benefitItem(ImageAssets.svg12, "Cancel anytime, no commitment"),
          _benefitItem(ImageAssets.svg13, "Ad-free, uninterrupted experience"),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) => Container(
    width: 200.w,
    padding: EdgeInsets.all(10.r),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20.r)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(ImageAssets.svg10, height: 15.h),
        SizedBox(width: 10.w),
        Text(text,
            style: AppTextStyles.arimoBold.copyWith(fontSize: 12.sp)),
      ],
    ),
  );

  Widget _buildPromoTag(String text) => Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
    decoration: BoxDecoration(
        color: AppColor.redBright30,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.redSoft.withOpacity(0.5))
    ),
    child: Text(text,
        style: AppTextStyles.arimoSemiBold.copyWith(
            color: AppColor.redSoft,
            fontSize: 13.sp
        )),
  );

  Widget _benefitItem(String svg, String text) => Padding(
    padding: EdgeInsets.only(bottom: 16.h),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(color: AppColor.darkOverlay30,
          borderRadius: BorderRadius.circular(10.r),

border: Border.all(color: AppColor.redBright30)
          ),

          child:SvgPicture.asset(svg,height: 15.h,color: AppColor.redBright,)
        ),
        SizedBox(width: 15.w),
        Expanded(
            child: Text(text,
                style: AppTextStyles.arimoRegular.copyWith(fontSize: 14.sp,color: AppColor.coolGray))
        ),
      ],
    ),
  );

  Widget _infoRow(IconData icon, String text) => Row(
    children: [
      Icon(icon, color: AppColor.grayish, size: 14.sp),
      SizedBox(width: 4.w),
      Text(text,
          style: AppTextStyles.arimoRegular.copyWith(
              color: AppColor.grayish,
              fontSize: 12.sp
          )),
    ],
  );

  Widget _buildFooterLinks() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Terms of Service",
          style: AppTextStyles.arimoRegular.copyWith(
              color: AppColor.coolGray,
              fontSize: 12.sp,
              decoration: TextDecoration.underline
          )),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text("and", style: AppTextStyles.arimoRegular.copyWith(
              color: AppColor.grayish,
              fontSize: 12.sp
          ))
      ),
      Text("Privacy Policy",
          style: AppTextStyles.arimoRegular.copyWith(
              color: AppColor.coolGray,
              fontSize: 12.sp,
              decoration: TextDecoration.underline
          )),
    ],
  );
}