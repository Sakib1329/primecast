import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  // Animation variables
  late Animation<double> logoScale; // Handle 100.h to 50.h transition
  late Animation<Offset> leftFieldSlide;
  late Animation<Offset> rightFieldSlide;
  late Animation<double> contentFade;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 2.0).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 60, // First 60% of the logo animation time
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 2.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40, // Remaining 40% to settle down
      ),
    ]).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6), // Logo finishes all movement by 60% of total time
      ),
    );

    // EMAIL: Slides from Left
    leftFieldSlide = Tween<Offset>(begin: const Offset(-2.5, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOutBack),
      ),
    );

    // PASSWORD: Slides from Right
    rightFieldSlide = Tween<Offset>(begin: const Offset(2.5, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 0.9, curve: Curves.easeOutBack),
      ),
    );

    // FADE: For text and buttons
    contentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}