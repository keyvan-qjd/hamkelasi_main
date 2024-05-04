import 'package:application/core/ApiRequest/ApiRequest.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:application/core/configs/app_colors.dart';
import 'package:application/src/authentication/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../recoveryPassword/recoveryPassScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value1 = false;
  bool value2 = false;
  var controller = Get.put<AuthenticationController>(
      AuthenticationController(dioHelper: DioHelper()));

  @override
  void initState() {
    super.initState();
    controller.changeAutoLogin(controller.storage.getAutoLogin());
    controller.chnageremindMeLater(controller.storage.getRemindMeLater());
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.teal.withOpacity(0.8),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 120.h,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'خوش آمدید',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        _buildUsernameTF(),
                        SizedBox(height: 30.h),
                        _buildPasswordTF(),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            Get.to(ForgottenPassword(),
                                transition: Transition.circularReveal);
                          },
                          child: Text(
                            "فراموشی رمز عبور ؟",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        _rememberMe(controller: controller),
                        SizedBox(height: 10.h),
                        _AutoLogin(controller: controller),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'برای استفاده از این قابلیت ابتدا باید من را به خاطر بسپار را فعال کرده باشید',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                        _buildLoginBtn(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'نام کاربری',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10),
        Center(
          child: TextFormField(
            controller: controller.username,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: inputDecorationGenerator(hint: 'نام کاربری'),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.length < 6 ||
                  value.length > 32 ||
                  !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                return 'لطفا یک نام کاربری معتبر وارد کنید';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'رمز عبور',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller.password,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: true,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: inputDecorationGenerator(hint: 'رمز عبور'),
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                value.length < 6 ||
                value.length > 32 ||
                !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
              return 'لطفا یک رمز عبور معتبر وارد کنید';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Obx(() {
      if (controller.isLoading.value) {
        return CircularProgressIndicator(
          color: AppColor.backGroundColor,
        );
      }
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              controller.Login(
                  username: controller.username.text,
                  password: controller.password.text);
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 5,
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.teal[800]!.withOpacity(.6),
          ),
          child: Text(
            'ورود',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      );
    });
  }

  final kHintTextStyle = const TextStyle(
    color: Colors.white54,
  );

  final kLabelStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  InputDecoration? inputDecorationGenerator({required String hint}) {
    return InputDecoration(
      fillColor: Colors.green[300]!.withOpacity(.6),
      filled: true,
      hintText: hint,
      hintStyle: kLabelStyle,
      labelStyle: kLabelStyle,
      errorStyle: kErrorTextStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  final kErrorTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14.0.sp,
    fontWeight: FontWeight.bold,
  );
}

class _AutoLogin extends StatelessWidget {
  const _AutoLogin({
    super.key,
    required this.controller,
  });

  final AuthenticationController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'ورود خودکار به سامانه',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(
          width: 10,
        ),
        Transform.scale(
          scale: 1.2,
          child: Obx(() => Checkbox.adaptive(
              checkColor: Colors.white,
              activeColor: AppColor.bottomNavigationBarColor,
              splashRadius: 49,
              value: controller.autoLogin.value,
              onChanged: (bool? val) => controller.changeAutoLogin(val))),
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}

class _rememberMe extends StatelessWidget {
  const _rememberMe({
    super.key,
    required this.controller,
  });

  final AuthenticationController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'من را به خاطر بسپار',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(
          width: 10,
        ),
        Transform.scale(
          scale: 1.2,
          child: Obx(() => Checkbox.adaptive(
              checkColor: Colors.white,
              activeColor: AppColor.bottomNavigationBarColor,
              splashRadius: 49,
              value: controller.remindMe.value,
              onChanged: (bool? val) => controller.chnageremindMeLater(val))),
        ),
      ],
    );
  }
}
