import 'package:application/core/entities/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService extends GetxController {
  late SharedPreferences prefs;

  @override
  void onInit() async {
    super.onInit();
    await initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }


  storeCustomData(key,value){
    prefs.setString(key, value);
  }
  String getCustomData(key){
  return prefs.getString(key) ?? '';
  }
  removeCustomData(key) async {
    await prefs.remove(key);
  }

  saveUserInfo(User user) {
    prefs.setString(dotenv.env['USERNAME_TOKEN_NAME']!, user.username);
    prefs.setString(dotenv.env['PASSWORD_TOKEN_NAME']!, user.password);
  }

  removeUserinfo() {
    prefs.remove(dotenv.env['USERNAME_TOKEN_NAME']!);
    prefs.remove(dotenv.env['PASSWORD_TOKEN_NAME']!);
  }

  User getUserValues() {
    String name = prefs.getString(dotenv.env['USERNAME_TOKEN_NAME']!) ?? '';
    String password = prefs.getString(dotenv.env['PASSWORD_TOKEN_NAME']!) ?? '';
    return User(username: name, password: password);
  }

  saveRemindMeLater(bool status) {
    prefs.setBool(dotenv.env['REMIND_ME_LATER_NAME']!, status);
  }

  bool getRemindMeLater() {
    bool? remindMeLater = prefs.getBool(dotenv.env['REMIND_ME_LATER_NAME']!);
    return remindMeLater ?? false;
  }

  saveAutoLogin(bool status) {
    prefs.setBool(dotenv.env['SAVE_AUTO_LOGIN_NAME']!, status);
  }

  bool getAutoLogin() {
    bool? autoLogin = prefs.getBool(dotenv.env['SAVE_AUTO_LOGIN_NAME']!);
    return autoLogin ?? false;
  }
}
