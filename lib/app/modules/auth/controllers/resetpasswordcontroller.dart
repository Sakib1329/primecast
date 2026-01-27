import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ResetPasswordController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  // Text Controllers
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  // ── NEW: Password validation observables ──
  var hasMinLength = false.obs;
  var hasUppercase  = false.obs;
  var hasNumber     = false.obs;
  var passwordsMatch = false.obs;

  // Timer logic for OTP
  RxInt timerSeconds = 57.obs;
  Timer? _timer;

  ResetPasswordController() {
    newPasswordController.addListener(_validatePasswords);
    confirmPasswordController.addListener(_validatePasswords);  // ← same function!
  }

  void _validatePasswords() {
    final newPass = newPasswordController.text;
    final confirmPass = confirmPasswordController.text;

    hasMinLength.value  = newPass.length >= 6;
    hasUppercase.value  = newPass.contains(RegExp(r'[A-Z]'));
    hasNumber.value     = newPass.contains(RegExp(r'[0-9]'));
    passwordsMatch.value = newPass == confirmPass && newPass.isNotEmpty;

    update();  // optional safety net
  }

  void startTimer() {
    timerSeconds.value = 57;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void goToPage(int index) {
    currentPage.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    if (index == 1) startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    newPasswordController.removeListener(_validatePasswords);
    newPasswordController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    pageController.dispose();
    super.onClose();
  }
}