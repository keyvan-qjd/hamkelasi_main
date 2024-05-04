import 'dart:convert';
import 'package:application/core/ApiRequest/ApiRequest.dart';
import 'package:application/core/configs/app_data.dart';
import 'package:application/core/entities/score.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_rx/get_rx.dart';

class HomeController extends GetxController {
  DioHelper dioHelper;
  RxBool isLoading = false.obs;
  RxList<Score> data = <Score>[].obs;
  RxString searchText = ''.obs;
  List<Score> allData = [];


    HomeController({required this.dioHelper});



  @override
  void onInit() {
    super.onInit();
    getScore();
  }


  void updateSearchText(String text) {
    if (text.isEmpty) { // if searchBox Empty show all data
      data.value = allData; ///
    } else {
      data.value = allData.where((score) { // search in all data and put to data
        return score.teacher.contains(text) ||
               score.examinetitle.contains(text) ||
               score.description.contains(text) ||
               score.className.contains(text) ||
               score.examineDate.contains(text) ||
               score.examineType.contains(text) ||
               score.courseName.contains(text);
      }).toList();
    }
  }

  Future<void> getScore() async {
    try {
      var getScores = jsonEncode({
        "jsonrpc": "2.0",
        "id": "REQUEST_ID",
        "method": "getStudentGradesList",
        "params": {"limit": "1,10"}
      });
      isLoading(true);
      dio.Response response =
          await dioHelper.getRequest(AppData.getScore, getScores);
      if (response.statusCode == 200) {
        if (response.data['status'] == 0) {
          for (var element in response.data['result']) {
            allData.add(Score.fromJson(element));
            data.add(Score.fromJson(element));
            isLoading(false);
          }
        }else{
          Get.snackbar('خطا','دریافت اطلاعات از سرور با خطا رو به رو شد . لطفا بعدا مجدد تلاش فرمایید');
        }
      }
    } catch (e) {
    }
  }
}
