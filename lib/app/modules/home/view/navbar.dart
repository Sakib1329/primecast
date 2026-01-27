import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:primecast/app/modules/music/views/Music.dart';
import 'package:primecast/app/modules/notification/views/notification.dart';
import 'package:primecast/app/modules/search/views/search.dart';
import 'package:primecast/app/res/colors/colors.dart';
import 'package:primecast/app/res/fonts/fonts.dart';


import '../../settings/views/settings.dart';
import '../controllers/home_controller.dart';
import 'home.dart';

class GoogleNavBarPage extends StatelessWidget {
  final Homecontroller controller = Get.find();

  GoogleNavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Homepage(),
                SearchPage(),
                MusicPage(),
               NotificationPage(),
                const SettingsPage(),



              ],
            ),
          ),
          Divider(color: AppColor.grayish,),
          Container(

            decoration: BoxDecoration(
              color: AppColor.deepForestGreen,
            ),
            padding: EdgeInsets.only(
              bottom: 20.h,
              left: 15.w,
              right: 15.w,
              top: 5.h,
            ),
            child: Obx(
                  () => GNav(
                rippleColor: AppColor.brightGreen,
                hoverColor: AppColor.deepForestGreen,
gap: 8,

                activeColor: AppColor.brightGreen,
                iconSize: 22.sp,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: AppColor.darkOverlay30,
                color: AppColor.coolGray,
             style: GnavStyle.google,
             textStyle: AppTextStyles.arimoBold.copyWith(fontSize: 12.sp,color: AppColor.brightGreen),
                tabs: [
                  GButton(icon: Icons.home, text: 'Home'),
                  GButton(icon: Icons.search, text: 'Search'),
                  GButton(icon: Icons.music_note, text: 'Music'),
                  GButton(icon: Icons.notification_important, text: 'Notification'),
                  GButton(icon: Icons.settings, text: 'Setting'),
                ],
                selectedIndex: controller.currentIndex.value,
                onTabChange: controller.changePage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
