import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/login_pref_getx.dart';

class ControllerSecondScreenPref extends GetxController {
  RxString token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    {
      token.value = pref.getString("login")!;
      update();
    }
  }

  void logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Get.offAll(() => LoginPrefGetX());
  }
}
