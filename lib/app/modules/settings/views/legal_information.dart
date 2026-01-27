import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../res/colors/colors.dart';
import '../../../res/fonts/fonts.dart';

import '../controllers/legal_information.dart';

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LegalController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          elevation: 0,
          leading: BackButton(color: AppColor.pureWhite, onPressed: () => Get.back()),
          title: Text("Legal Information",
              style: AppTextStyles.arimoBold.copyWith(fontSize: 20.sp)),
          bottom: TabBar(
            indicatorColor: AppColor.brightGreen,
            indicatorWeight: 3,
            labelColor: AppColor.pureWhite,
            unselectedLabelColor: AppColor.grayish,
            labelStyle: AppTextStyles.arimoBold.copyWith(fontSize: 14.sp),
            tabs: const [
              Tab(text: "Terms of Service", icon: Icon(Icons.description_outlined, size: 20)),
              Tab(text: "Privacy Policy", icon: Icon(Icons.security_outlined, size: 20)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLegalContent(controller.termsOfService, controller.lastUpdated, "Terms of Service",Icons.description_outlined,),
            _buildLegalContent(controller.privacyPolicy, controller.lastUpdated, "Privacy Policy",Icons.security_outlined,),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalContent(List<Map<String, dynamic>> sections, String date, String title,IconData icon) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColor.darkOverlay30,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColor.brightGreen.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColor.brightGreen, size: 30.sp),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.arimoBold.copyWith(fontSize: 18.sp)),
                    Text("Last Updated: $date",
                        style: AppTextStyles.arimoRegular.copyWith(fontSize: 12.sp, color: AppColor.grayish)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 25.h),

          // Sections
          ...sections.map((section) => _buildSection(section)).toList(),
          Text(
            "By continuing to use PrimeCast, you acknowledge that you have read and understood these legal documents.",
            style: AppTextStyles.arimoRegular.copyWith(color: AppColor.grayish, fontSize: 13.sp, height: 1.5),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> section) {
    return Container(
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColor.darkOverlay30,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section['title'],
              style: AppTextStyles.arimoBold.copyWith(fontSize: 16.sp, color: AppColor.pureWhite)),
          SizedBox(height: 10.h),
          Text(section['content'],
              style: AppTextStyles.arimoRegular.copyWith(
                  fontSize: 14.sp, color: AppColor.coolGray, height: 1.6)),
          if (section.containsKey('bullets')) ...[
            SizedBox(height: 10.h),
            ...(section['bullets'] as List<String>).map((bullet) => Padding(
              padding: EdgeInsets.only(bottom: 6.h, left: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("• ", style: TextStyle(color: AppColor.brightGreen, fontSize: 16.sp)),
                  Expanded(
                    child: Text(bullet,
                        style: AppTextStyles.arimoRegular.copyWith(
                            fontSize: 13.sp, color: AppColor.coolGray, height: 1.4)),
                  ),
                ],
              ),
            )),
          ]
        ],
      ),
    );
  }
}