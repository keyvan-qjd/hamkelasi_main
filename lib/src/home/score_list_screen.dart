import 'package:application/core/ApiRequest/ApiRequest.dart';
import 'package:application/core/configs/app_colors.dart';
import 'package:application/src/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreList extends StatelessWidget {
  var controller =
      Get.put<HomeController>(HomeController(dioHelper: DioHelper()));
  @override
  Widget build(BuildContext context) {
    controller.getScore();
    return Scaffold(
      appBar: AppBar(
        title: const Text('نمرات دانش آموز'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.mainColor, AppColor.bottomNavigationBarColor],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => controller.updateSearchText(value),
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(.4),
                hintTextDirection: TextDirection.rtl,
                hintText: 'جست و جوی نمرات',
                prefixIcon: Icon(Icons.search, color: AppColor.mainColor),
                // suffixIcon:
                //     Icon(Icons.pause_presentation, color: AppColor.mainColor),
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return CircularProgressIndicator(
                color: AppColor.mainColor,
              );
            }
            if (controller.data.isEmpty) {
              return const Text(
                'موردی پیدا نشد',
                style: TextStyle(fontSize: 20),
              );
            } else {
              return Expanded(
                child: ListView.separated(
                    itemCount: controller.data.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: AppColor.mainColor),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.book, color: AppColor.mainColor),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'نام درس : ${controller.data[index].courseName} | ',
                                style: Theme.of(context).textTheme.subtitle2),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Text('نمره : ${controller.data[index].grade} | ',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                'کلاس : ${controller.data[index].className} | ',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                'توضیحات : ${controller.data[index].description} | ',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                'نوع امتحان : ${controller.data[index].examineType} | ',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                'زمان امتحان: ${controller.data[index].examineDate} | ',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                'اسم امتحان :  ${controller.data[index].examinetitle} | ',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            color: AppColor.mainColor),
                      );
                    }),
              );
            }
          })
        ],
      ),
    );
  }
}
