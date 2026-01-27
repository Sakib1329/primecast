import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:primecast/app/modules/auth/views/success.dart';

import '../../../res/assets/asset.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/textfield.dart';
import '../controllers/resetpasswordcontroller.dart';
import 'login.dart';

class ResetPasswordMainPage extends StatelessWidget {
  const ResetPasswordMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());

    return Scaffold(
      backgroundColor: AppColor.deepForestGreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics:
                  const NeverScrollableScrollPhysics(), // Controlled via buttons
              children: const [
                ForgotPasswordStep(),
                VerifyOTPStep(),
                ResetPasswordInputStep(),
              ],
            ),
          ),

          Obx(
            () => Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 8.h,
                    width: controller.currentPage.value == index ? 24.w : 8.w,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? AppColor.brightGreen
                          : AppColor.darkOverlay30,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordStep extends StatelessWidget {
  const ForgotPasswordStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          _buildStepHeader(
            Icons.email_outlined,
            "Forgot Password?",
            "No worries!\nEnter your email address and we'll send you a OTP to reset your password.",
          ),
          SizedBox(height: 40.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email Address",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          InputTextWidget(
            hintText: "your.email@example.com",
            leading: true,
            hintTextColor: AppColor.coolGray,
            leadingIcon: ImageAssets.email,
            backgroundColor: AppColor.darkOverlay30,
            borderColor: AppColor.brightGreen,
            textColor: Colors.white,
            onChanged: (String value) {},
          ),
          SizedBox(height: 30.h),
          CustomButton(
            title: "Send OTP",
            onPress: () async => controller.goToPage(1),
            buttonColor: AppColor.brightGreen,
            borderColor: AppColor.brightGreen,
            fontWeight: FontWeight.w900,
          ),
          SizedBox(height: 20.h),
          Divider(color: AppColor.coolGray),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(color: AppColor.coolGray, fontSize: 12.sp),
              ),
              GestureDetector(
                onTap: () {
                  Get.off(LoginPage(), transition: Transition.rightToLeft);
                },

                child: Text(
                  "Sign In",
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
    );
  }
}

class ResetPasswordInputStep extends StatelessWidget {
  const ResetPasswordInputStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: _buildStepHeader(
              Icons.lock_reset_rounded,
              "Reset Password",
              "Create a new password",
            ),
          ),
          SizedBox(height: 30.h),
          const Text(
            "New Password",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          // New Password field
          InputTextWidget(
            hintText: "Enter new password",
            leading: true,
            leadingIcon: ImageAssets.lock,
            hintTextColor: AppColor.grayish,
            obscureText: true,
            hintfontWeight: FontWeight.bold,
            backgroundColor: AppColor.darkOverlay30,
            borderColor: AppColor.brightGreen,
            textColor: Colors.white,

            // ── Important changes ──
            controller:
                Get.find<ResetPasswordController>().newPasswordController,
 onChanged: (String value) {  },
          ),
          SizedBox(height: 20.h),
          // Confirm Password field
          InputTextWidget(
            hintText: "Confirm new password",
            leading: true,
            leadingIcon: ImageAssets.lock,
            hintTextColor: AppColor.grayish,
            obscureText: true,
            hintfontWeight: FontWeight.bold,
            backgroundColor: AppColor.darkOverlay30,
            borderColor: AppColor.brightGreen,
            textColor: Colors.white,

            // ── Important changes ──
            controller:
                Get.find<ResetPasswordController>().confirmPasswordController,
            onChanged: (v) {}, // optional
          ),
          SizedBox(height: 25.h),
          _buildRequirementsCard(),
          SizedBox(height: 30.h),
          Obx(() {
            final ctrl = Get.find<ResetPasswordController>();

            final isValid =
                ctrl.hasMinLength.value &&
                    ctrl.hasUppercase.value &&
                    ctrl.hasNumber.value &&
                    ctrl.passwordsMatch.value;   // ← use the new observable here

            // Debug print (remove later)
            print("Button Obx → isValid: $isValid   "
                "match: ${ctrl.passwordsMatch.value}   "
                "new: '${ctrl.newPasswordController.text}'   "
                "confirm: '${ctrl.confirmPasswordController.text}'");

            return CustomButton(
              title: "Reset Password",
              onPress: isValid ? () async {
                Get.off(SuccessStep(), transition: Transition.rightToLeft);
              } : null,
              buttonColor: isValid ? AppColor.brightGreen : AppColor.deepForestGreen,
              borderColor: AppColor.brightGreen,
              textColor: isValid ? AppColor.black : AppColor.pureWhite,
              borderShadowColor: isValid ? AppColor.brightGreen : AppColor.darkOverlay30,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRequirementsCard() {
    final controller = Get.find<ResetPasswordController>();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.darkOverlay30,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.brightGreen.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Password Requirements:",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),

          // Make the whole card reactive
          Obx(
            () => Column(
              children: [
                _reqRow(
                  text: "At least 6 characters",
                  isValid: controller.hasMinLength,
                ),
                _reqRow(
                  text: "One uppercase letter",
                  isValid: controller.hasUppercase,
                ),
                _reqRow(text: "One number", isValid: controller.hasNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reqRow({required String text, required RxBool isValid}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(
            isValid.value ? Icons.check_circle : Icons.circle,
            color: isValid.value ? AppColor.brightGreen : AppColor.coolGray,
            size: isValid.value ? 14.sp : 6.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              color: isValid.value ? AppColor.brightGreen : AppColor.coolGray,
              fontSize: 12.sp,
              fontWeight: isValid.value ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// --- SHARED UI HELPERS ---
Widget _buildStepHeader(IconData icon, String title, String subtitle) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(25.w),
        decoration: BoxDecoration(
          color: AppColor.darkOverlay30,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColor.brightGreen, size: 50.sp),
      ),
      SizedBox(height: 20.h),
      Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8.h),
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColor.coolGray, fontSize: 14.sp),
      ),
    ],
  );
}

class VerifyOTPStep extends StatelessWidget {
  const VerifyOTPStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          _buildStepHeader(
            Icons.lock_outline_rounded,
            "Verify OTP",
            "Check your email for the code",
          ),
          SizedBox(height: 10.h),
          Text(
            "We sent a 6-digit code to",
            style: TextStyle(color: AppColor.coolGray),
          ),
          Text(
            "abuawad.arman123@gmail.com",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30.h),
          PinCodeTextField(
            appContext: context,
            keyboardType: TextInputType.number,
            controller: controller.otpController,
            length: 4,
            enabled: true,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10.r),
              fieldHeight: 50.h,
              fieldWidth: 60.w,
              activeFillColor: AppColor.deepForestGreen,
              selectedFillColor: AppColor.darkOverlay30,
              inactiveFillColor: AppColor.darkOverlay30,

              activeColor: AppColor.brightGreen, // border when filled
              selectedColor: AppColor.pureWhite, // border when focused
              inactiveColor: AppColor.brightGreen, // subtle border
            ),
            textStyle: AppTextStyles.arimoBold.copyWith(
              color: AppColor.pureWhite,
              fontSize: 18.sp,
            ),
            enableActiveFill: true,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            onChanged: (_) {},
          ),
          SizedBox(height: 40.h),
          CustomButton(
            title: "Verify OTP",
            onPress: () async => controller.goToPage(2),
            buttonColor: AppColor.brightGreen,
            borderColor: AppColor.brightGreen,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: 20.h),
          Obx(
            () => RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Resend code in ",
                    style: TextStyle(color: AppColor.coolGray, fontSize: 14.sp),
                  ),
                  TextSpan(
                    text:
                        " 0:${controller.timerSeconds.value.toString().padLeft(2, '0')}",

                    style: TextStyle(
                      color: Colors.white, // 👈 time in white
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class SuccessStep extends StatelessWidget {
  const SuccessStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepForestGreen, // match your theme
      body: SafeArea(  // optional but recommended
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleIcon(
                Icons.check_circle_outline,
                color: AppColor.brightGreen,
              ),
              SizedBox(height: 30.h),
              Text(
                "Password Reset Successful!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                "Your password has been successfully reset.\nYou can now login with your new password.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.coolGray),
              ),
              SizedBox(height: 40.h),
              CustomButton(
                title: "Back to Login",
                onPress: () async {
                  Get.off(LoginPage(), transition: Transition.rightToLeft);

                },

                buttonColor: AppColor.brightGreen,
                borderShadowColor: AppColor.brightGreen,
                borderColor: AppColor.brightGreen,

              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCircleIcon(IconData icon, {Color? color}) => Container(
    padding: EdgeInsets.all(25.w),
    decoration: BoxDecoration(
      color: AppColor.darkOverlay30,
      shape: BoxShape.circle,
    ),
    child: Icon(icon, color: color ?? AppColor.brightGreen, size: 50.sp),
  );

  Widget _buildSignLink(String text, String action) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text, style: TextStyle(color: AppColor.coolGray)),
      Text(
        action,
        style: TextStyle(
          color: AppColor.brightGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}