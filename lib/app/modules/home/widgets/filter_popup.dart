import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Local state for selections
  String selectedType = "All";
  String selectedYear = "All Years";
  String selectedRating = "All Ratings";
  String selectedSort = "Most Popular";
  List<String> selectedGenres = ["Action"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.darkGray, // Dark background from your UI
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildIconBox(Icons.tune),
                    SizedBox(width: 12.w),
                    Text(
                      "Filters",
                      style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white54),
                ),
              ],
            ),


            // Content Type
            _buildSectionTitle("Content Type"),
            _buildSelectionRow(
              ["All", "Movie", "Series"],
              selectedType,
              (v) => setState(() => selectedType = v),
            ),

            // Genres (Wrap for many items)
            _buildSectionTitle("Genres"),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                "Action",
                "Drama",
                "Comedy",
                "Thriller",
                "Sci-Fi",
                "Mystery",
                "Crime",
                "Romance",
                "Adventure",
              ].map((g) => _buildGenreChip(g)).toList(),
            ),

            // Release Year
            _buildSectionTitle("Release Year"),
            _buildSelectionGrid(
              ["All Years", "2024", "2023", "2022"],
              selectedYear,
              (v) => setState(() => selectedYear = v),
            ),

            // Minimum Rating
            _buildSectionTitle("Minimum Rating"),
            _buildSelectionGrid(
              ["All Ratings", "8.0+", "7.0+", "6.0+"],
              selectedRating,
              (v) => setState(() => selectedRating = v),
            ),

            // Sort By (List Style)
            _buildSectionTitle("Sort By"),
            Column(
              children: [
                "Most Popular",
                "Highest Rated",
                "Newest First",
                "A-Z",
              ].map((s) => _buildSortItem(s)).toList(),
            ),

            SizedBox(height: 30.h),

            // Bottom Actions
            Row(
              children: [
                Expanded(child: _buildActionButton("Reset", isOutline: true)),
                SizedBox(width: 15.w),
                Expanded(child: _buildActionButton("Apply Filters")),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  // --- UI HELPER WIDGETS ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 25.h, bottom: 15.h),
      child: Text(
        title,
        style: AppTextStyles.arimoBold.copyWith(
          fontSize: 16.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildIconBox(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColor.brightGreen,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(icon, color: Colors.black, size: 20.sp),
    );
  }

  Widget _buildSelectionRow(
    List<String> items,
    String current,
    Function(String) onSelect,
  ) {
    return Row(
      children: items.map((item) {
        bool isSelected = item == current;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(item),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: 40.h,
              decoration: isSelected
                  ? _selectedDecoration()
                  : _unselectedDecoration(),
              alignment: Alignment.center,
              child: Text(item, style: _chipTextStyle(isSelected)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSelectionGrid(
    List<String> items,
    String current,
    Function(String) onSelect,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.5,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        bool isSelected = items[index] == current;
        return GestureDetector(
          onTap: () => onSelect(items[index]),
          child: Container(
            decoration: isSelected
                ? _selectedDecoration()
                : _unselectedDecoration(),
            alignment: Alignment.center,
            child: Text(items[index], style: _chipTextStyle(isSelected)),
          ),
        );
      },
    );
  }

  Widget _buildGenreChip(String genre) {
    bool isSelected = selectedGenres.contains(genre);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? selectedGenres.remove(genre) : selectedGenres.add(genre);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration:
        isSelected
            ? _selectedDecoration()
            : _unselectedDecoration(), // Genres usually stay grey until selected
        child: Text(
          genre,
          style: AppTextStyles.arimoRegular.copyWith(
            fontSize: 12.sp,
            color: isSelected ? AppColor.black : Colors.white60,
          ),
        ),
      ),
    );
  }

  Widget _buildSortItem(String title) {
    bool isSelected = selectedSort == title;
    return GestureDetector(
      onTap: () => setState(() => selectedSort = title),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: isSelected
            ? _selectedDecoration()
            : _unselectedDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: _chipTextStyle(isSelected)),
            if (isSelected)
              const Icon(Icons.check, color: Colors.black, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, {bool isOutline = false}) {
    return Container(
      height: 40.h,
      decoration: isOutline
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
            )
          : BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.greenSemi, AppColor.greenTeal],
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.brightGreen.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: AppTextStyles.arimoBold.copyWith(
          color: isOutline ? Colors.white : Colors.black,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  // --- STYLES ---

  BoxDecoration _selectedDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColor.greenSemi, AppColor.greenTeal.withOpacity(0.9)],
      ),
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(color: AppColor.brightGreen.withOpacity(0.4), blurRadius: 8),
      ],
    );
  }

  BoxDecoration _unselectedDecoration() {
    return BoxDecoration(
      color: AppColor.darkOverlay30,
      borderRadius: BorderRadius.circular(10.r),
    );
  }

  TextStyle _chipTextStyle(bool isSelected) {
    return AppTextStyles.arimoMedium.copyWith(
      fontSize: 14.sp,
      color: isSelected ? Colors.black : AppColor.coolGray,
    );
  }
}
