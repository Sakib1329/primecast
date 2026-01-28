import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Controller to handle the search text input
  final TextEditingController _searchController = TextEditingController();

  // Mock data based on your UI
  final List<String> trendingSearches = [
    "Action Movies",
    "Sci-Fi Series",
    "Comedy Specials",
    "Documentaries",
    "Thrillers"
  ];

  final List<String> recentSearches = [
    "Breaking Boundaries",
    "The Last Kingdom",
    "Dark Secrets"
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // 1. Search Bar
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColor.darkOverlay30,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  controller: _searchController,
                  style: AppTextStyles.arimoRegular.copyWith(color: Colors.white),
                  onChanged: (value) {
                    // Logic to filter results as the user types
                  },
                  decoration: InputDecoration(
                    hintText: "Search movies, shows, genres...",
                    hintStyle: AppTextStyles.arimoRegular.copyWith(
                      color: Colors.white38,
                      fontSize: 15.sp,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.white38, size: 22.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                  ),
                ),
              ),

              SizedBox(height: 35.h),

              // 2. Trending Searches Section
              Row(
                children: [
                  Icon(Icons.trending_up, color: AppColor.brightGreen, size: 20.sp),
                  SizedBox(width: 10.w),
                  Text(
                    "Trending Searches",
                    style: AppTextStyles.arimoBold.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: trendingSearches.map((tag) => _buildTrendingChip(tag)).toList(),
              ),

              SizedBox(height: 40.h),

              // 3. Recent Searches Section
              Row(
                children: [
                  Icon(Icons.history, color: Colors.white38, size: 20.sp),
                  SizedBox(width: 10.w),
                  Text(
                    "Recent Searches",
                    style: AppTextStyles.arimoBold.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: ListView.builder(
                  itemCount: recentSearches.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return _buildRecentSearchTile(recentSearches[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI HELPER WIDGETS ---

  Widget _buildTrendingChip(String label) {
    return GestureDetector(
      onTap: () => _searchController.text = label,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColor.darkOverlay30,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.arimoMedium.copyWith(
            fontSize: 12.sp,
            color: AppColor.coolGray,
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSearchTile(String title) {
    return GestureDetector(
      onTap: () => _searchController.text = title,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColor.darkOverlay30,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, color: Colors.white38, size: 18.sp),
            SizedBox(width: 15.w),
            Text(
              title,
              style: AppTextStyles.arimoRegular.copyWith(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}