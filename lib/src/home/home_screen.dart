import 'package:application/core/ApiRequest/ApiRequest.dart';
import 'package:application/core/configs/app_colors.dart';
import 'package:application/src/authentication/controller/authentication_controller.dart';
import 'package:application/src/home/score_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var AuthController = Get.put<AuthenticationController>(
        AuthenticationController(dioHelper: DioHelper()));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('خانه'),
        centerTitle: true,
        backgroundColor: AppColor.mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
            ),

            ButtonTheme(
              minWidth: double.infinity,
              child: ElevatedButton.icon(
                icon: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Icon(Icons.list_alt, color: Colors.white)),
                label: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: const Text('لیست نمرات دانش آموز',
                      style: TextStyle(color: Colors.white)),
                ),
                onPressed: () {
                  Get.to(ScoreList(), transition: Transition.circularReveal);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 14,
            ),

            Obx(() {
              if (AuthController.isLoading.value) {
                return CircularProgressIndicator(
                  color: AppColor.backGroundColor,
                );
              }

              //list

              return ButtonTheme(
                minWidth: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(Icons.home, color: Colors.white)),
                  label: const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child:
                          Text('خروج', style: TextStyle(color: Colors.white))),
                  onPressed: () async {
                    await AuthController.logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.mainColor,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),

            //Exit
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: GNav(
          onTabChange: (index) {
            print(index);
          },
          tabBorderRadius: 15,
          color: Colors.black12,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.teal,
          backgroundColor: Colors.white,
          gap: 8,
          padding: EdgeInsets.all(12),
          tabs: [
            GButton(
              text: 'تفویم',
              icon: LineIcons.calendar,
              iconColor: Colors.grey,
            ),
            GButton(
              iconColor: Colors.grey,
              text: 'میز کار',
              icon: LineIcons.home,
            ),
            GButton(
              icon: LineIcons.search,
              text: 'رسانه',
              iconColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}



// bottomNavigationBar: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           child: GNav(
//             onTabChange: (index) {
//               print(index);
//             },
//             tabBorderRadius: 15,
//             color: Colors.white,
//             activeColor: Colors.white,
//             tabBackgroundColor: Colors.teal.shade200,
//             backgroundColor: Colors.white,
//             gap: 8,
//             padding: EdgeInsets.all(12),
//             tabs: [
//               GButton(
//                 text: 'تفویم',
//                 icon: LineIcons.calendar,
//                 iconColor: Colors.grey,
//               ),
//               GButton(
//                 iconColor: Colors.grey,
//                 text: 'میز کار',
//                 icon: LineIcons.home,
//               ),
//               GButton(
//                 icon: LineIcons.search,
//                 text: 'رسانه',
//                 iconColor: Colors.grey,
//               ),
//             ],
//           ),
//         ),