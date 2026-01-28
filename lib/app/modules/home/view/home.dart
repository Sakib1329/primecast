import 'package:flutter/cupertino.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:primecast/app/modules/home/controllers/home_controller.dart';

import '../../../res/assets/asset.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/content_details_controller.dart';
import 'content_details.dart';
import 'home_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Homecontroller controller = Get.find();

    return Scaffold(
      backgroundColor: AppColor.deepForestGreen, // Ensure background matches
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSlider(controller),

            _buildSectionHeader("Continue Watching", () => Get.to(() => SeeAllMoviesPage(title: "Continue Watching", list: controller.continueWatchingList))),
            _buildContinueWatchingList(controller.continueWatchingList),

            _buildSectionHeader("New Releases", () => Get.to(() => SeeAllMoviesPage(title: "New Releases", list: controller.newReleases))),
            _buildStandardHorizontalList(controller.newReleases),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  // Corrected: Wrap item in GestureDetector to navigate
  Widget _buildStandardHorizontalList(List<MovieModel> list) {
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return GestureDetector(
            onTap: () => Get.to(() => ContentDetailsScreen(content: ContentModel.fromMovieModel(item))),
            child: Container(
              width: 140.w,
              margin: EdgeInsets.only(right: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(item.imageUrl, height: 160.h, width: 140.w, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 8.h),
                  Text(item.title, style: AppTextStyles.arimoBold.copyWith(fontSize: 14.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(item.category, style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.coolGray)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Corrected Hero Slider: Added navigation to "Play" and "More Info"
  Widget _buildHeroSlider(Homecontroller controller) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 480.h,
        viewportFraction: 1.0,
        autoPlay: true,
      ),
      items: controller.newHeroList.map((item) {
        return Stack(
          children: [
            Image.asset(item.imageUrl, width: double.infinity, height: 520.h, fit: BoxFit.cover),
            _buildGradientOverlay(),
            _buildTopAppBar(),
            Positioned(
              bottom: 30.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroBadge(item.category),
                  SizedBox(height: 12.h),
                  Text(item.title, style: AppTextStyles.arimoBold.copyWith(fontSize: 30.sp, height: 1.1)),
                  SizedBox(height: 12.h),
                  Text(item.description ?? "", maxLines: 2, style: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray, fontSize: 12.sp)),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      // PASS ITEM TO BUTTONS
                      _buildButton("Play Now", Icons.play_arrow, AppColor.brightGreen, Colors.black, () {
                        Get.to(() => ContentDetailsScreen(content: ContentModel.fromMovieModel(item)));
                      }),
                      SizedBox(width: 12.w),
                      _buildButton("More Info", Icons.info_outline, Colors.white.withOpacity(0.15), Colors.white, () {
                        Get.to(() => ContentDetailsScreen(content: ContentModel.fromMovieModel(item)));
                      }),
                    ],
                  )
                ],
              ),
            )
          ],
        );
      }).toList(),
    );
  }

  // Modified Helper: Added onTap callback to remove 'item' undefined error
  Widget _buildButton(String label, IconData icon, Color bg, Color textCol, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          children: [
            Icon(icon, color: textCol, size: 20.sp),
            SizedBox(width: 5.w),
            Text(label, style: AppTextStyles.arimoBold.copyWith(color: textCol, fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }

  // --- REUSABLE UI COMPONENTS ---
  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.4),
            AppColor.deepForestGreen.withOpacity(0.96)
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBadge(String category) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(color: AppColor.brightGreen, borderRadius: BorderRadius.circular(4.r)),
          child: Text("NEW", style: AppTextStyles.arimoBold.copyWith(fontSize: 12.sp, color: Colors.black)),
        ),
        SizedBox(width: 12.w),
        Expanded(child: Text(category, style: AppTextStyles.arimoMedium.copyWith(color: AppColor.coolGray, fontSize: 14.sp))),
      ],
    );
  }

  Widget _buildTopAppBar() {
    return Positioned(
      top: 40.h, left: 20.w, right: 20.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(ImageAssets.svg1, height: 28.h),
              SizedBox(width: 10.w),
              Text("PrimeCast", style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp, color: Colors.white)),
            ],
          ),
          Row(
            children: [
              _buildAppBarIcon(Icons.search, () {}),
              SizedBox(width: 10.w),
              _buildAppBarIcon(Icons.person_outline, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(icon, color: Colors.white, size: 22.sp),
      ),
    );
  }

  Widget _buildContinueWatchingList(List<MovieModel> list) {
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return GestureDetector(
            onTap: () => Get.to(() => ContentDetailsScreen(content: ContentModel.fromMovieModel(item))),
            child: Container(
              width: 140.w,
              margin: EdgeInsets.only(right: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(item.imageUrl, height: 160.h, width: 140.w, fit: BoxFit.cover),
                      ),
                      if (item.progress != null)
                        Container(
                          height: 4.h,
                          width: 140.w,
                          color: Colors.white24,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: item.progress ?? 0.0,
                              child: Container(color: AppColor.brightGreen),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(item.title, style: AppTextStyles.arimoBold.copyWith(fontSize: 14.sp), maxLines: 1),
                  Text(item.category, style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.coolGray)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.arimoBold.copyWith(fontSize: 18.sp)),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text("See All", style: AppTextStyles.arimoMedium.copyWith(color: AppColor.brightGreen, fontSize: 12.sp)),
                Icon(Icons.arrow_forward_ios, color: AppColor.brightGreen, size: 12.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
