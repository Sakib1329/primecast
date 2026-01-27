import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:primecast/app/modules/auth/views/login.dart';
import '../../../res/assets/asset.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/textfield.dart';
import '../controllers/signupcontroller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: AppColor.deepForestGreen,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),

              // --- BOUNCING LOGO ---
              ScaleTransition(
                scale: controller.logoScale,
                child: SvgPicture.asset(ImageAssets.svg1, height: 50.h),
              ),

              SizedBox(height: 20.h),

              // --- HEADER TEXT ---
              FadeTransition(
                opacity: controller.contentFade,
                child: Column(
                  children: [
                    Text("Create Account",
                        style: AppTextStyles.arimoBold.copyWith(fontSize: 32.sp, color: Colors.white)),
                    SizedBox(height: 8.h),
                    Text("Join PrimeCast for unlimited entertainment",
                        style: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray)),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // --- FORM FIELDS (Alternating Sides) ---
              SlideTransition(
                position: controller.leftFieldSlide,
                child: _buildField("Full Name", ImageAssets.user), // Use your user icon
              ),
              SizedBox(height: 15.h),

              SlideTransition(
                position: controller.rightFieldSlide,
                child: _buildField("Email Address", ImageAssets.email),
              ),
              SizedBox(height: 15.h),

              SlideTransition(
                position: controller.leftFieldSlide,
                child: _buildField("Phone Number", ImageAssets.svg9), // Use your phone icon
              ),
              SizedBox(height: 15.h),

              SlideTransition(
                position: controller.rightFieldSlide,
                child: _buildField("Password", ImageAssets.lock, isPassword: true),
              ),
              SizedBox(height: 15.h),

              SlideTransition(
                position: controller.rightFieldSlide,
                child: _buildField("Confirm Password", ImageAssets.lock, isPassword: true),
              ),

              SizedBox(height: 30.h),

              // --- SIGN UP BUTTON & FOOTER ---
              FadeTransition(
                opacity: controller.contentFade,
                child: Column(
                  children: [
                    CustomButton(
                      title: "Sign Up",
                      onPress: () async{},
                      borderColor: AppColor.brightGreen,
                      buttonColor: AppColor.brightGreen,
                      textColor: AppColor.black111214,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 20.h),

                    // Already have an account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",
                            style: TextStyle(color: AppColor.coolGray, fontSize: 12.sp)),
                        GestureDetector(
                          onTap: () {
                            Get.off(LoginPage(),transition: Transition.rightToLeft);
                          },

                          child: Text("Sign In",
                              style: TextStyle(color: AppColor.brightGreen, fontWeight: FontWeight.bold, fontSize: 14.sp)),
                        ),
                      ],
                    ),

                    SizedBox(height: 25.h),

                    // "Or continue with" section
                    _buildSocialSection(),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String hint, String icon, {bool isPassword = false}) {
    return InputTextWidget(
      hintText: hint,
      leading: true,
      leadingIcon: icon,
      obscureText: isPassword,
      hintTextColor: AppColor.grayish,
      backgroundColor: AppColor.darkOverlay30,
      borderColor: AppColor.brightGreen,
      textColor: Colors.white,
      onChanged: (v) {},
    );
  }

  Widget _buildSocialSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: AppColor.darkOverlay30, thickness: 2, endIndent: 10.w)),
            Text("Or continue with", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
            Expanded(child: Divider(color: AppColor.darkOverlay30, thickness: 2, indent: 10.w)),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            _socialIcon(ImageAssets.svg6),
            SizedBox(width: 12.w),
            _socialIcon(ImageAssets.svg7),
            SizedBox(width: 12.w),
            _socialIcon(ImageAssets.svg8),
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(String asset) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: AppColor.darkOverlay30,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.brightGreen.withOpacity(0.5)),
        ),
        child: SvgPicture.asset(asset),
      ),
    );
  }
}