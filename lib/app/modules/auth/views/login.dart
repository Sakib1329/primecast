import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:primecast/app/modules/auth/views/reset_password.dart';
import 'package:primecast/app/modules/auth/views/signup.dart';
import 'package:primecast/app/modules/auth/views/subscription.dart';
import '../../../res/assets/asset.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/textfield.dart';
import '../controllers/logincontroller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: AppColor.deepForestGreen,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 80.h),

              // --- BOUNCING LOGO ---
              ScaleTransition(
                scale: controller.logoScale,
                child: SvgPicture.asset(
                  ImageAssets.svg1,
                  height: 50.h, // Base size is 50. Scale 2.0 makes it 100.
                ),
              ),
              SizedBox(height: 30.h),

              // --- WELCOME TEXT (Fades in) ---
              FadeTransition(
                opacity: controller.contentFade,
                child: Column(
                  children: [
                    Text(
                      "Welcome Back",
                      style: AppTextStyles.arimoBold.copyWith(
                        fontSize: 32.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Sign in to continue streaming",
                      style: AppTextStyles.arimoRegular.copyWith(
                        color: AppColor.coolGray,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // --- EMAIL: COMES FROM LEFT ---
              SlideTransition(
                position: controller.leftFieldSlide,
                child: InputTextWidget(
                  hintText: "Email Address",
                  leading: true,
                  hintTextColor: AppColor.grayish,
                  hintfontWeight: FontWeight.bold,
                  leadingIcon: ImageAssets.email,
                  backgroundColor: AppColor.darkOverlay30,
                  borderColor: AppColor.brightGreen,
                  textColor: Colors.white,
                  onChanged: (v) {},
                ),
              ),

              SizedBox(height: 20.h),

              // --- PASSWORD: COMES FROM RIGHT ---
              SlideTransition(
                position: controller.rightFieldSlide,
                child: InputTextWidget(
                  hintText: "Password",
                  leading: true,
                  leadingIcon: ImageAssets.lock,
                  hintTextColor: AppColor.grayish,
                  obscureText: true,
                  hintfontWeight: FontWeight.bold,
                  backgroundColor: AppColor.darkOverlay30,
                  borderColor: AppColor.brightGreen,
                  textColor: Colors.white,
                  onChanged: (v) {},
                ),
              ),

              // Forgot Password link
              FadeTransition(
                opacity: controller.contentFade,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.off(ResetPasswordMainPage(),transition:Transition.rightToLeft);
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: AppColor.brightGreen),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // --- BUTTON & FOOTER (Fades in last) ---
              FadeTransition(
                opacity: controller.contentFade,
                child: Column(
                  children: [
                    CustomButton(
                      title: "Sign In",
                      onPress: () async {
                        Get.off(PremiumSubscriptionPage(),transition: Transition.rightToLeft);
                      },

                      borderColor: AppColor.brightGreen,
                      buttonColor: AppColor.brightGreen,
                      textColor: AppColor.black111214,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: AppColor.coolGray,
                            fontSize: 12.sp,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Get.off(SignUpPage(),transition: Transition.rightToLeft);
                          },

                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: AppColor.brightGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FadeTransition(
                opacity: controller.contentFade, // Matches the button fade timing
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColor.darkOverlay30,
                            thickness: 2,
                            endIndent: 10.w,
                          ),
                        ),
                        Text(
                          "Or continue with",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.spMax,
                            fontFamily: 'Sans',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColor.darkOverlay30,
                            thickness: 2,
                            indent: 10.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // --- SOCIAL BUTTONS ROW ---
                    Row(
                      children: [
                        _buildSocialTile(ImageAssets.svg6, onTap: () {}),
                        SizedBox(width: 12.w),
                        _buildSocialTile(ImageAssets.svg7, onTap: () {}),
                        SizedBox(width: 12.w),
                        _buildSocialTile(ImageAssets.svg8, onTap: () {}),
                      ],
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSocialTile(String asset, {required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: AppColor.darkOverlay30,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColor.brightGreen.withOpacity(0.5)),
          ),
          child: SvgPicture.asset(asset),
        ),
      ),
    );
  }

}
