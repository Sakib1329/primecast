import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:primecast/app/modules/settings/views/editprofile.dart';
import 'package:primecast/app/modules/settings/views/legal_information.dart';
import 'package:primecast/app/modules/settings/views/my_list.dart';
import 'package:primecast/app/modules/settings/views/notification_settings.dart';
import 'package:primecast/app/modules/settings/views/subscription_status.dart';
import 'package:primecast/app/modules/settings/views/watch_history.dart';

import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../../../widgets/custom_button.dart'; // Your AppTextStyles path

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                "Profile",
                style: AppTextStyles.arimoBold.copyWith(fontSize: 28.sp),
              ),
              Divider(color: AppColor.coolGray,),
              SizedBox(height: 10.h),

              // --- USER INFORMATION CARD ---
              _buildUserHeaderCard(),

              SizedBox(height: 32.h),

              // --- CONTENT SECTION ---
              _buildSectionTitle("CONTENT"),
              _buildProfileOption(
                icon: Icons.favorite_border,
                title: "My List",
                subtitle: "Your saved shows and movies",
                trailing: "12 items",
                onTap: () {
                  Get.to(MyListPage(),transition: Transition.rightToLeft);
                },
              ),
              SizedBox(height: 10.h,),
              _buildProfileOption(
                icon: Icons.access_time,
                title: "Watching History",
                subtitle: "Recently watched content",
                trailing: "24 items",
                onTap: () {
                  Get.to(WatchingHistoryScreen(),transition: Transition.rightToLeft);
                },
              ),

              SizedBox(height: 32.h),

              // --- ACCOUNT SECTION ---
              _buildSectionTitle("ACCOUNT"),
              _buildProfileOption(
                icon: Icons.workspace_premium,
                title: "Subscription",
                subtitle: "Premium Plan",
                isSubscription: true,
                onTap: () {

                  Get.to(SubscriptionPage(),transition: Transition.rightToLeft);
                },

              ),
              SizedBox(height: 10.h,),
              _buildProfileOption(
                icon: Icons.person_outline,
                title: "Edit Profile",
                subtitle: "Update your personal information",
                onTap: () {
                  Get.to(EditProfilePage(),transition: Transition.rightToLeft);
                },

              ),
              SizedBox(height: 10.h,),
              _buildProfileOption(
                icon: Icons.credit_card,
                title: "Payment Methods",
                subtitle: "Manage payment & billing",
                onTap: () {},
              ),

              SizedBox(height: 32.h),

              // --- SETTINGS SECTION ---
              _buildSectionTitle("SETTINGS"),
              _buildProfileOption(
                icon: Icons.notifications_none,
                title: "Notifications",
                subtitle: "Push, email & SMS preferences",
                onTap: () {
                  Get.to(NotificationSettingsPage(),transition: Transition.rightToLeft);
                },
              ),
              SizedBox(height: 10.h,),
              _buildProfileOption(
                icon: Icons.description_outlined,
                title: "Legal",
                subtitle: "Terms of Service & Privacy Policy",
                onTap: () {
                  Get.to(LegalPage(),transition: Transition.rightToLeft);
                },
              ),

              SizedBox(height: 20.h),

              // --- LOGOUT BUTTON ---
              _buildLogoutButton(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildUserHeaderCard() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColor.greenSemi,
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          colors: [
            AppColor.greenSemi,
            AppColor.greenTeal,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColor.pureWhite.withOpacity(0.2),
                child: Icon(Icons.person, size: 40.r, color: AppColor.pureWhite),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("John Doe",
                      style: AppTextStyles.arimoBold.copyWith(fontSize: 22.sp)),
                  Text("johndoe@email.com",
                      style: AppTextStyles.arimoRegular.copyWith(fontSize: 14.sp)),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderStat("Member Since", "January 2024"),
              _buildHeaderStat("Watch Time", "128 Hours"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyles.arimoRegular.copyWith(
                fontSize: 12.sp,
                color: AppColor.pureWhite.withOpacity(0.8)
            )),
        Text(value,
            style: AppTextStyles.arimoBold.copyWith(fontSize: 16.sp)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(
        title,
        style: AppTextStyles.arimoSemiBold.copyWith(
          fontSize: 14.sp,
          color: AppColor.coolGray,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    String? trailing,
    bool isSubscription = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
      decoration: BoxDecoration(
        color: AppColor.darkOverlay30,
        borderRadius: BorderRadius.circular(12.r)
      ),
        padding: EdgeInsets.all(15.w),
        child: Row(
          children: [
            Icon(icon, color: AppColor.brightGreen, size: 28.r),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title,
                          style: AppTextStyles.arimoSemiBold.copyWith(fontSize: 14.sp)),
                      if (isSubscription) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColor.brightGreen,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text("Active",
                              style: AppTextStyles.arimoBold.copyWith(fontSize: 10.sp)),
                        ),
                      ]
                    ],
                  ),
                  Text(subtitle,
                      style: AppTextStyles.arimoRegular.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.coolGray
                      )),
                  if (trailing != null)
                    Text(trailing,
                        style: AppTextStyles.arimoRegular.copyWith(
                            fontSize: 11.sp,
                            color: AppColor.grayish
                        )),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColor.grayish, size: 16.r),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return InkWell( // Added InkWell to make it clickable
      onTap: () {
        _showLogoutPopup();
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColor.redBright30,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.redDark),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColor.redBright30,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.logout, color: AppColor.redBright, size: 24.r),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Log Out",
                    style: AppTextStyles.arimoBold.copyWith(
                        fontSize: 16.sp,
                        color: AppColor.redBright
                    )),
                Text("Sign out of your account",
                    style: AppTextStyles.arimoRegular.copyWith(
                        fontSize: 12.sp,
                        color: AppColor.coolGray
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- LOGOUT POPUP LOGIC ---
  void _showLogoutPopup() {
    Get.defaultDialog(
      backgroundColor: AppColor.deepForestGreen,
      radius: 20.r,
      title: "Log Out",
      titleStyle: AppTextStyles.arimoBold.copyWith(
        color: AppColor.pureWhite,
        fontSize: 18.sp,
      ),
      titlePadding: EdgeInsets.only(top: 24.h),
      contentPadding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),

      content: Column(
        children: [
          SizedBox(height: 8.h),
          Text(
            "Are you sure you want to log out of your account?",
            textAlign: TextAlign.center,
            style: AppTextStyles.arimoRegular.copyWith(
              color: AppColor.coolGray,
              fontSize: 14.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 28.h),

          // 🔘 Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  title: "Cancel",
                  height: 45.h,
                  radius: 10,
                  buttonColor: Colors.transparent,
                  borderColor: AppColor.coolGray,
                  textColor: AppColor.coolGray,
                  onPress: () async => Get.back(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  title: "Log Out",
                  height: 45.h,
                  radius: 10,
                  buttonColor: AppColor.redBright,
                  borderColor: AppColor.redBright,
                  textColor: AppColor.pureWhite,
                  onPress: () async{
                    Get.back();
                    print("User Logged Out");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
