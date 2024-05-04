import 'dart:convert';
import 'dart:developer';
import 'package:application/core/ApiRequest/ApiRequest.dart';
import 'package:application/core/Exception/Exception.dart';
import 'package:application/core/configs/app_data.dart';
import 'package:application/core/entities/user.dart';
import 'package:application/core/services/LocalStorage.dart';
import 'package:application/src/authentication/login_screen.dart';
import 'package:application/src/home/home_screen.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  var remindMe = false.obs;
  var autoLogin = false.obs;

  var remindMeSave;
  var autoLoginSave;

  final LocalStorageService storage = Get.put(LocalStorageService());
  DioHelper dioHelper;


  AuthenticationController({required this.dioHelper});

  final formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  // Login network Request States

  RxBool isLoading = false.obs;

  bool initLocalStorage = false;

  @override
  void onInit() async {
    super.onInit();
      if (storage.getUserValues().username != '') {
        if (storage.getAutoLogin() && storage.getRemindMeLater()) {
          remindMe(storage.getRemindMeLater());
          autoLogin(storage.getAutoLogin());
          autoLoginApp();
        }

        remindMeSave = storage.getRemindMeLater();
        autoLoginSave = storage.getAutoLogin();
        username.text = storage.getUserValues().username;
        password.text = storage.getUserValues().password;
      }
  }

  void chnageremindMeLater(value) {
    if (!value) {
      autoLogin(false);
      remindMeSave = '';
      remindMe(false);
      storage.saveAutoLogin(false);
      storage.saveRemindMeLater(false);
    } else {
      remindMeSave = '';
      storage.saveRemindMeLater(true);
      remindMe(true);
    }
  }

  void changeAutoLogin(value) {
    if (remindMe.value && value) {
      storage.saveAutoLogin(true);
      autoLogin(true);
      autoLoginSave = '';
    } else if (!value) {
      storage.saveAutoLogin(false);
      autoLogin(false);
      autoLoginSave = '';
    } else {
      Get.snackbar(
          'خطا', 'ابتدا باید گزینه من را به خاطر بسپار را فعال کرده باشید');
    }
  }

  autoLoginApp() async {
    if (storage.getRemindMeLater() && storage.getAutoLogin()) {
      await Login(
          username: storage.getUserValues().username,
          password: storage.getUserValues().password);
    }
  }

  Future<void> Login(
      {required String username, required String password}) async {
    try {
      var formLoginData = {
        "jsonrpc": "2.0",
        "id": "12",
        "method": "login",  
        "params": {"user": username.toString(), "pass": password.toString()}
      };
      isLoading(true);
      dio.Response response = await dioHelper.postRequest(
          AppData.loginApiUrl, jsonEncode(formLoginData));
      if (response.statusCode == 200) {
        // -===================== if success login
        if (response.data['status'] == 0) {
          if (response.headers['set-cookie'] != null) {
            storage.storeCustomData(
              dotenv.env['SESSION_TOKEN_NAME'],
              response.headers['set-cookie']!.first.split(';')[0],
            );
          }
          isLoading(false);

          Get.snackbar('خوش آمدید',
              'ورود به حساب کاربری با موفقیت انجام شد . تا چند لحظه دیگر به صفحه هدایت میشوید');
          Future.delayed(const Duration(seconds: 2), () {
            if (remindMe.value) {
              // if user want to save data
              storage
                  .saveUserInfo(User(username: username, password: password));
            } else {
              storage.removeUserinfo();
            }
            Get.off(() => HomeScreen(), transition: Transition.topLevel);
          });
        } else {
          AppException exception = showException(response.data['error']['code'],
              response.data['error']['message']);
          isLoading(false);
          Get.snackbar('خطا در ورود به حساب', exception.message);
        }
      }
    } catch (e) {
      isLoading(false);
      log("Error ===> $e");
      Get.snackbar('خطای لاگین', 'در هنگام لاگین مشکلی به وجود آمد');
    }
  }

  Future logout() async {
    try {
      var formLoginData = {
        "jsonrpc": "2.0",
        "id": "123",
        "method": "logout",
        "params": {
          "user": storage.getUserValues().username,
          "pass": storage.getUserValues().password
        }
      };
      isLoading(true);
      dio.Response response = await dioHelper.postRequest(
          AppData.loginApiUrl, jsonEncode(formLoginData));
      if (response.statusCode == 200) {
        if (response.data['status'] == 0) {
          isLoading(false);
          Get.off(LoginScreen());
          Get.snackbar(
              'خروج از حساب کاربری', 'با موفقیت از حساب کاربری خارج شدید');
          storage.removeUserinfo();
          storage.saveAutoLogin(false);
          storage.saveRemindMeLater(true);
        }
      }
    } catch (e) {
      isLoading(false);
      log("Error ===> $e");
      Get.snackbar('خطای لاگین', 'در هنگام لاگین مشکلی به وجود آمد');
    }
  }
}
