import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/content_details_controller.dart';
import 'castingPage.dart';

class ContentDetailsScreen extends StatelessWidget {
  final ContentModel content;
  late final DetailsController controller;

  ContentDetailsScreen({Key? key, required this.content}) : super(key: key) {
    // Unique tag allows opening multiple detail screens in the stack
    controller = Get.put(DetailsController(content), tag: content.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepForestGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  // Massive Title
                  Text(
                      content.title,
                      style: AppTextStyles.arimoBold.copyWith(fontSize: 25.sp, color: Colors.white)
                  ),
                  SizedBox(height: 8.h),
                  _buildMetaData(),
                  SizedBox(height: 16.h),
                  // Description
                  Text(
                      content.description,
                      style: AppTextStyles.arimoRegular.copyWith(
                          color: AppColor.coolGray,
                          fontSize: 14.sp,
                          height: 1.4
                      )
                  ),
                  SizedBox(height: 24.h),
                  _buildActionButtons(),
                  SizedBox(height: 20.h),
                  _buildGenreTags(),
                  SizedBox(height: 24.h),
                  _buildCastSection(),
                  SizedBox(height: 24.h),
                  _buildDynamicSection(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Stack(
      children: [
        SizedBox(
          height: 300.h,
          width: double.infinity,
          child: Image.asset(
            content.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        // Gradient overlay
        Container(
          height: 300.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.6, 1.0],
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.transparent,
                AppColor.deepForestGreen,
              ],
            ),
          ),
        ),
        // Back Button
        Positioned(
          top: 45.h,
          left: 16.w,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: CircleAvatar(
              backgroundColor: AppColor.black111214.withOpacity(0.5),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetaData() {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 18.sp),
        SizedBox(width: 4.w),
        Text(
            content.rating,
            style: AppTextStyles.arimoBold.copyWith(color: Colors.amber, fontSize: 14.sp)
        ),
        Text(
            "  •  ${content.year}  •  ",
            style: AppTextStyles.arimoMedium.copyWith(color:AppColor.coolGray, fontSize: 14.sp)
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
              color: AppColor.darkGray,
              borderRadius: BorderRadius.circular(4.r)
          ),
          child: Text(
              content.ageRating,
              style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: Colors.white)
          ),
        ),
        Text(
            "  •  ${content.durationOrSeasons}",
            style: AppTextStyles.arimoMedium.copyWith(color:AppColor.coolGray, fontSize: 14.sp)
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logic to start playback
                },
                icon: Icon(Icons.play_arrow_rounded, size: 28.sp, color: Colors.black),
                label: Obx(() {
                  // TRICK: We always read the observable value first.
                  // This keeps Obx happy even if we are viewing a Movie.
                  final currentSeason = controller.selectedSeason.value;

                  // Now we decide what to show
                  String buttonText = content.isSeries
                      ? "Play S$currentSeason E1"
                      : "Play";

                  return Text(
                    buttonText,
                    style: AppTextStyles.arimoBold.copyWith(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  );
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.brightGreen,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            _buildIconButton(Icons.add),
            SizedBox(width: 12.w),
            _buildIconButton(Icons.download_outlined),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Get.to(CastDevicePage(),transition: Transition.rightToLeft);
            },

            icon: Icon(Icons.cast, size: 18.sp, color: AppColor.brightGreen),
            label: Text(
              "Cast to Device",
              style: AppTextStyles.arimoMedium.copyWith(
                color: AppColor.pureWhite,
                fontSize: 14.sp,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColor.darkOverlay30,
              side: const BorderSide(color: AppColor.darkGray),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration:  BoxDecoration(color: AppColor.darkGray, borderRadius: BorderRadius.circular(12.r)),
      child: Icon(icon, color: Colors.white, size: 20.sp),
    );
  }

  Widget _buildGenreTags() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: content.genres.map((g) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
            color: AppColor.darkGray.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.white10)
        ),
        child: Text(
            g,
            style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: Colors.white)
        ),
      )).toList(),
    );
  }

  Widget _buildCastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Cast",
            style: AppTextStyles.arimoSemiBold.copyWith(fontSize: 18.sp, color: Colors.white)
        ),
        SizedBox(height: 8.h),
        Text(
            content.cast.join(", "),
            style: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray, fontSize: 14.sp)
        ),
      ],
    );
  }

  Widget _buildDynamicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            content.isSeries ? "Episodes" : "More Like This",
            style: AppTextStyles.arimoSemiBold.copyWith(fontSize: 20.sp, color: Colors.white)
        ),
        SizedBox(height: 10.h),
        if (content.isSeries) _buildSeasonSelector(),
        SizedBox(height: 16.h),
        _buildContentList(),
      ],
    );
  }

  Widget _buildSeasonSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) => Obx(() {
          bool isSelected = controller.selectedSeason.value == index + 1;
          return GestureDetector(
            onTap: () => controller.changeSeason(index + 1),
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.brightGreen : AppColor.darkOverlay30,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                  "Season ${index + 1}",
                  style: AppTextStyles.arimoMedium.copyWith(
                      color: isSelected ? Colors.black : Colors.white,
                      fontSize: 14.sp
                  )
              ),
            ),
          );
        })),
      ),
    );
  }
  Widget _buildContentList() {
    return Obx(() {
      if (content.isSeries) {
        // --- SERIES LAYOUT (Flush Image) ---
        return Column(
          children: controller.episodes.map((episode) {
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              clipBehavior: Clip.antiAlias, // Ensures image corners follow container radius
              decoration: BoxDecoration(
                color: AppColor.darkOverlay30,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Flush Image (no padding here)
                  Image.asset(
                    episode.imageUrl,
                    width: 100.w, // Fixed width
                    height: 80.h,  // Fixed height to fill the side
                    fit: BoxFit.cover,
                  ),
                  // Content with Padding
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12.r), // Internal text padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "E${episode.id}. ${episode.title}",
                                style: AppTextStyles.arimoSemiBold.copyWith(
                                    fontSize: 14.sp,
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                episode.duration,
                                style: AppTextStyles.arimoRegular.copyWith(
                                    fontSize: 11.sp,
                                    color: AppColor.coolGray
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            episode.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.arimoRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.coolGray
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      } else {
        // --- MOVIE LAYOUT (Flush Image) ---
        return Column(
          children: controller.recommendations.map((movie) {
            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              clipBehavior: Clip.antiAlias, // Critical for flush image corners
              decoration: BoxDecoration(
                color: AppColor.darkGray,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  // Flush Image
                  Image.asset(
                    movie.imageUrl,
                    width: 140.w,
                    height: 100.h, // Adjusted height for a flush look
                    fit: BoxFit.cover,
                  ),
                  // Padded Content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: AppTextStyles.arimoBold.copyWith(
                                fontSize: 16.sp,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${movie.year} • ${movie.category}",
                            style: AppTextStyles.arimoRegular.copyWith(
                                fontSize: 13.sp,
                                color: AppColor.coolGray
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 14.sp),
                              SizedBox(width: 4.w),
                              Text(
                                movie.rating,
                                style: AppTextStyles.arimoMedium.copyWith(
                                    fontSize: 13.sp,
                                    color: Colors.amber
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      }
    });
  }

}