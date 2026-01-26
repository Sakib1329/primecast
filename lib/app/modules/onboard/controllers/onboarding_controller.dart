import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:primecast/app/modules/auth/views/login.dart';
import 'package:primecast/app/modules/onboard/views/onboard.dart';
import 'package:primecast/app/res/assets/asset.dart';



class OnboardController extends GetxController
    with GetSingleTickerProviderStateMixin {

  late AnimationController animationController;

  late Animation<double> logoScaleAnimation;
  late Animation<double> logoFadeAnimation;
  late Animation<Offset> titleSlideAnimation;
  late Animation<double> titleFadeAnimation;
  late Animation<Offset> subtitleSlideAnimation;
  late Animation<double> subtitleFadeAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // Logo
    logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );
    logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );

    // Title
    titleSlideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.6, curve: Curves.easeOutCubic),
      ),
    );
    titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.5, curve: Curves.easeIn),
      ),
    );

    // Subtitle
    subtitleSlideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOutCubic),
      ),
    );
    subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    animationController.forward();

    startTimer(); // start navigation timer
  }

  void startTimer() {
    Timer(const Duration(seconds: 5), routeUser);
  }

  void routeUser() {
    final token = GetStorage().read<String>('loginToken');
    if (token != null && token.isNotEmpty) {
      Get.offAllNamed('/home');
    } else {
      Get.offAll(OnboardingPage());
    }
  }
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Unlimited\nEntertainment",
      "subtitle": "Stream thousands of movies, TV shows, and exclusive originals anytime, anywhere.",
      "icon": ImageAssets.svg2,
    },
    {
      "title": "Download & Watch\nOffline",
      "subtitle": "Download your favorites and watch them offline on the go without internet.",
      "icon": ImageAssets.svg3,
    },
    {
      "title": "Cast to Any Device",
      "subtitle": "Enjoy seamless casting to your TV, tablet, or any screen in your home.",
      "icon": ImageAssets.svg4,
    },
    {
      "title": "Premium Content",
      "subtitle": "Get access to exclusive shows, early releases, and ad-free streaming.",
      "icon": ImageAssets.svg5,
    },
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextStep() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
  Get.to(LoginPage(),transition: Transition.fadeIn);
    }
  }

  void skip() {
    // Jump to the last page or navigate away
    pageController.jumpToPage(onboardingData.length - 1);
  }
  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}