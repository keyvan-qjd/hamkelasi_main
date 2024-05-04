import 'package:application/core/configs/app_colors.dart';
import 'package:application/core/services/LocalStorage.dart';
import 'package:application/src/intro/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Get.putAsync<LocalStorageService>(() async => LocalStorageService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          theme: ThemeData(
            primaryColor: AppColor.mainColor,
            textTheme: TextTheme(
              headline6:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              subtitle1: TextStyle(
                  color: AppColor.mainColor, fontWeight: FontWeight.w600),
              subtitle2: TextStyle(color: AppColor.textColor),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              hintStyle: TextStyle(color: AppColor.mainColor),
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: 'Hamkelasi',
          home: const SplashScreen(),
        );
      },
    );
  }
}
