import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:primecast/app/modules/onboard/controllers/onboarding_controller.dart';

import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../../../widgets/custom_button.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OnboardController controller = Get.find();

    return Scaffold(
      backgroundColor: AppColor.deepForestGreen,
      body: SafeArea(
        child: Stack(
          children: [
            // Skip Button
            Positioned(
              top: 20.h,
              right: 24.w,
              child: GestureDetector(
                onTap: controller.skip,
                child: Text(
                  "Skip",
                  style: AppTextStyles.arimoRegular.copyWith(
                    color: AppColor.coolGray,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),

            // Content Slider
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.onboardingData.length,
              itemBuilder: (context, index) {
                final item = controller.onboardingData[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIcon(item['icon']!),
                      SizedBox(height: 15.h),
                      Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.arimoBold.copyWith(
                          fontSize: 28.sp,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        item['subtitle']!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.arimoRegular.copyWith(
                          color: AppColor.coolGray,

                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Bottom Navigation (Dots and Button)
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Dot Indicator
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.onboardingData.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 8.h,
                        width: controller.currentPage.value == index ? 24.w : 8.w,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == index
                              ? AppColor.brightGreen
                              : AppColor.coolGray.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(height: 40.h),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Obx(() => CustomButton(
                      onPress: () async => controller.nextStep(),
                      title: controller.currentPage.value == controller.onboardingData.length - 1
                          ? "Get Started"
                          : "Next",
                      arrowicon: true,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                      buttonColor: AppColor.brightGreen,
                      textColor: AppColor.black, // Contrast for the green button
                      borderColor: Colors.transparent,
                      borderShadowColor: AppColor.black,

                      radius: 30.r,
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to choose the right icon/SVG based on data
  Widget _buildIcon(String assetPath) {
    return SvgPicture.asset(
      assetPath,
      width: 80.w, // Adjust size based on your design
      height: 80.h,
      colorFilter: const ColorFilter.mode(
        AppColor.brightGreen,
        BlendMode.srcIn,
      ),
    );
  }
}