import 'package:application/gen/assets.gen.dart';
import 'package:application/src/authentication/controller/authentication_controller.dart';
import 'package:application/src/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Get.off(LoginScreen(), transition: Transition.fadeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.h,
          ),
          SizedBox(
            width: 450.w,
            height: 480.h,
            child: Image.asset(Assets.splash.path),
          ),
          SizedBox(
            height: 40.h,
          ),
        ],
      ),
    );
  }
}
