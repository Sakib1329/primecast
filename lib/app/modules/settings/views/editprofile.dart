import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:primecast/app/modules/auth/views/reset_password.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../../../res/assets/asset.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/textfield.dart';


class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        elevation: 0,
        leading: BackButton(onPressed: () => Get.back(), color: AppColor.pureWhite),
        title: Text("Edit Profile",
            style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 30.h),

            // Input Fields using your custom widget
            _buildInputField("Full Name", "John Doe", ImageAssets.user),
            SizedBox(height: 16.h),
            _buildInputField("Email Address", "johndoe@email.com", ImageAssets.email),
            SizedBox(height: 16.h),
            _buildInputField("Phone Number", "+1 234 567 8900", ImageAssets.svg9),
            SizedBox(height: 16.h),
            _buildInputField("Date of Birth", "mm/dd/yyyy", ImageAssets.svg19),

            SizedBox(height: 24.h),

            // Change Password Card
            _buildChangePasswordCard(),

            SizedBox(height: 40.h),

            // Action Buttons
            CustomButton(
              title: "Save",
              onPress: () async {

              },

              borderColor: AppColor.brightGreen,
              buttonColor: AppColor.brightGreen,
              textColor: AppColor.black111214,
              fontSize: 14.sp,
              height: 45.h,
              fontWeight: FontWeight.w800,
            ),
            SizedBox(height: 20.h),
            CustomButton(
              title: "Cancel",
              onPress: () async {

              },

              borderColor: AppColor.redDark,
              buttonColor: AppColor.deepForestGreen,
              textColor: AppColor.redDark,
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              height: 45.h,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 55.r,
              backgroundColor: AppColor.brightGreen,
              child: SvgPicture.asset(ImageAssets.user,color: AppColor.pureWhite,height: 60.h,),
            ),
            Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: AppColor.brightGreen,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.black, width: 3.w),
              ),
              child: Icon(Icons.camera_alt, size: 16.sp, color: AppColor.black),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Text("Change Profile Photo",
            style: AppTextStyles.arimoMedium.copyWith(fontSize: 14.sp, color: AppColor.grayish)),
      ],
    );
  }

  Widget _buildInputField(String label, String hint, String icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.arimoBold.copyWith(fontSize: 14.sp, color: AppColor.grayish)),
        SizedBox(height: 8.h),
        InputTextWidget(
          hintText: hint,
          leading: true,
          leadingIcon: icon,
          backgroundColor: AppColor.darkOverlay30,
          borderColor: Colors.transparent, // Clean look like your screenshot
          textColor: AppColor.pureWhite,
          hintTextColor: AppColor.coolGray,
          fontFamily: 'Arimo', // Using Arimo as requested
          onChanged: (val) {},
        ),
      ],
    );
  }

  Widget _buildChangePasswordCard() {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColor.darkOverlay30,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.brightGreen.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColor.brightGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.lock_outline_rounded, color: AppColor.brightGreen, size: 22.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Change Password",
                      style: AppTextStyles.arimoBold.copyWith(fontSize: 16.sp, color: AppColor.pureWhite)),
                  Text("Update your security credentials",
                      style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.grayish)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColor.grayish, size: 16.sp),
          ],
        ),
      ),
    );
  }


}