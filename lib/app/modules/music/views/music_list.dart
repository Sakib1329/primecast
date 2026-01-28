import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';
import '../controllers/music_controller.dart';

class SeeAllMusicPage extends StatelessWidget {
  final String title;
  final List<MusicModel> list;
  const SeeAllMusicPage({super.key, required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 0,
        title: Text(title, style: AppTextStyles.arimoBold),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Get.back()),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(20.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 15.w,
          childAspectRatio: 0.8,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) => _verticalMusicCard(list[index]),
      ),
    );
  }

  Widget _verticalMusicCard(MusicModel music) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.asset(music.image, fit: BoxFit.cover, width: double.infinity),
          ),
        ),
        SizedBox(height: 8.h),
        Text(music.title, style: AppTextStyles.arimoBold.copyWith(fontSize: 14.sp)),
        Text(music.artist, style: AppTextStyles.arimoRegular.copyWith(color: AppColor.coolGray, fontSize: 12.sp)),
      ],
    );
  }
}