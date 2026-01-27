

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:primecast/app/modules/home/controllers/home_controller.dart';

import 'app/modules/onboard/controllers/onboarding_controller.dart';
import 'app/modules/onboard/views/splash_view.dart';
import 'app/res/colors/colors.dart';


void main() async {


  await GetStorage.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  Get.put(OnboardController());

  Get.put(Homecontroller());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360,690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        print('Initial ScreenUtil scaleWidth: ${ScreenUtil().scaleWidth}');
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(

            debugShowCheckedModeBanner: false,
            title: "Application",
            home: SplashScreen(),
            theme: ThemeData(
              scaffoldBackgroundColor:   AppColor.deepForestGreen,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                backgroundColor:   AppColor.deepForestGreen,
                scrolledUnderElevation: 0,
              ),
            ),
          ),
        );
      },
    );
  }
}