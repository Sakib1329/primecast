import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../res/assets/asset.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/music_controller.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'music_list.dart';

class MusicHomePage extends StatelessWidget {
  const MusicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MusicController());

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),

              // 1. FEATURED CAROUSEL (Top of TabBar)
              _buildFeaturedCarousel(controller),

              SizedBox(height: 20.h),

              // 2. SCROLLABLE TABS
              _buildCategoryTabs(controller),

              // 3. SECTIONS
              _buildSectionHeader("Trending Now", () => Get.to(() => SeeAllMusicPage(title: "Trending Now", list: controller.trendingMusic))),
              _buildHorizontalList(controller.trendingMusic),

              _buildSectionHeader("New Releases", () => Get.to(() => SeeAllMusicPage(title: "New Releases", list: controller.newReleases))),
              _buildHorizontalList(controller.newReleases),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCarousel(MusicController controller) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.h,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        onPageChanged: (index, reason) => controller.currentCarouselIndex.value = index,
      ),
      items: controller.featuredVideos.map((music) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: AssetImage(music.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // --- 1. Center Play Button ---
                    Center(
                      child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2), // Frosted glass effect
                          shape: BoxShape.circle,

                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: AppColor.brightGreen, // Using your theme color
                          size: 60.sp,
                        ),
                      ),
                    ),

                    // --- 2. Text Content (Featured Tag & Info) ---
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Featured Tag at the top
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColor.brightGreen,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              "FEATURED",
                              style: AppTextStyles.arimoBold.copyWith(
                                fontSize: 10.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Title and Artist at the bottom
                          Text(
                            music.title,
                            style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp),
                          ),
                          Text(
                            "${music.artist} • ${music.views}",
                            style: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray,fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
            },
        );
      }).toList(),
    );
  }

  Widget _buildCategoryTabs(MusicController controller) {
    return SizedBox(
      height: 35.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) => Obx(() => GestureDetector(
          onTap: () => controller.changeTab(index),
          child: Container(
            margin: EdgeInsets.only(right: 12.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: controller.selectedTab.value == index ? AppColor.brightGreen : AppColor.darkOverlay30,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              controller.categories[index],
              style: AppTextStyles.arimoMedium.copyWith(
                color: controller.selectedTab.value == index ? AppColor.black : AppColor.pureWhite,
                fontSize: 14.sp,
              ),
            ),
          ),
        )),
      ),
    );
  }

  // --- REUSABLE WIDGETS FROM PREVIOUS VERSION ---
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.music_note, color: AppColor.brightGreen, size: 28.sp),
              SizedBox(width: 8.w),
              Text("Music Videos", style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp)),
            ],
          ),
          Text("Discover the latest music hits", style: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray, fontSize: 14.sp)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.arimoBold.copyWith(fontSize: 18.sp)),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text("See All", style: AppTextStyles.arimoMedium.copyWith(color: AppColor.brightGreen, fontSize: 14.sp)),
                Icon(Icons.arrow_forward_ios, color: AppColor.brightGreen, size: 12.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(List<MusicModel> list) {
    return SizedBox(

      height: 180.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: list.length,
        itemBuilder: (context, index) => _musicCard(list[index]),
      ),
    );
  }

  Widget _musicCard(MusicModel music) {
    return Container(
      width: 180.w,
      margin: EdgeInsets.only(right: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(music.image, height: 110.h, width: 180.w, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  color: Colors.black.withOpacity(0.7),
                  child: Text(music.duration, style: AppTextStyles.arimoRegular.copyWith(fontSize: 10.sp)),
                ),
              )
            ],
          ),
          SizedBox(height: 8.h),
          Text(music.title, style: AppTextStyles.arimoBold.copyWith(fontSize: 15.sp), maxLines: 1),
          Text(music.artist, style: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray, fontSize: 13.sp)),
          Text(music.views, style: AppTextStyles.arimoRegular.copyWith(color: AppColor.grayish, fontSize: 11.sp)),
        ],
      ),
    );
  }


}
