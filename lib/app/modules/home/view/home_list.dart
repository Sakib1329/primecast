import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/home_controller.dart';
import '../widgets/filter_popup.dart';

class SeeAllMoviesPage extends StatelessWidget {
  final String title;
  final List<MovieModel> list;
  const SeeAllMoviesPage({super.key, required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        elevation: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.arimoBold.copyWith(fontSize: 18.sp)),
            Text("${list.length} titles",
                style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.coolGray)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Allows it to take more height
                  backgroundColor: Colors.transparent,
                  builder: (context) => const FilterBottomSheet(),
                );
              },
              icon: Icon(Icons.tune, color: Colors.white, size: 24.sp)
          )
        ],
      ),
      body: Column(
        children: [
          // 1. Search Bar inside the category
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: SizedBox(
              height: 40.h, // reduce total height
              child: TextField(

                enabled: true, // set false to disable
                style: AppTextStyles.arimoRegular.copyWith(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(

                  hintText: "Search in this category...",
                  hintStyle: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray, fontSize: 14.sp),
                  prefixIcon: Icon(Icons.search, color: AppColor.coolGray, size: 20.sp),
                  filled: true,
                  fillColor: AppColor.darkOverlay30,
                  isDense: true, // makes the field more compact
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h), // reduced padding

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColor.brightGreen, width: 1.5.w),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColor.coolGray.withOpacity(0.5), width: 1.5.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColor.brightGreen, width: 2.w),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColor.redBright, width: 2.w),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColor.redBright, width: 2.w),
                  ),
                ),
                cursorColor: AppColor.brightGreen,
              ),
            )


          ),

          // 2. Grid List
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.62, // Adjusted to prevent overflow
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 20.h,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) => _buildGridCard(list[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridCard(MovieModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Poster Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  item.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Rating Badge - Now shows for EVERYTHING (Continue Watching + New Releases)
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 12.sp),
                      SizedBox(width: 4.w),
                      Text(
                        item.rating,
                        style: AppTextStyles.arimoBold.copyWith(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Progress Bar - Shows ONLY if progress data exists
              if (item.progress != null)
                Container(
                  height: 4.h,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: item.progress!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.brightGreen,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          item.title,
          style: AppTextStyles.arimoBold.copyWith(fontSize: 14.sp),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          item.category,
          style: AppTextStyles.arimoRegular.copyWith(
            fontSize: 11.sp,
            color: AppColor.coolGray,
          ),
        ),
        Text(
          item.yearType ?? "",
          style: AppTextStyles.arimoRegular.copyWith(
            fontSize: 11.sp,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }
}