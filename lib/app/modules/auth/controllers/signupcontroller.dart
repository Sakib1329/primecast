import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> logoScale;
  late Animation<Offset> leftFieldSlide;  // For Name, Phone
  late Animation<Offset> rightFieldSlide; // For Email, Passwords
  late Animation<double> contentFade;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Logo: 100.h to 50.h sequence
    logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 2.0).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 2.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
    ]).animate(CurvedAnimation(parent: animationController, curve: const Interval(0.0, 0.5)));

    // Left Slide
    leftFieldSlide = Tween<Offset>(begin: const Offset(-2.0, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.3, 0.7, curve: Curves.easeOutBack)),
    );

    // Right Slide
    rightFieldSlide = Tween<Offset>(begin: const Offset(2.0, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.4, 0.8, curve: Curves.easeOutBack)),
    );

    // Fade for footer
    contentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.6, 1.0, curve: Curves.easeIn)),
    );

    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}