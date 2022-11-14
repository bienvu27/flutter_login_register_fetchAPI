import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_register_flutter/login_shared_preferences_getx/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/second_screen_pref.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final userModel = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void login({String? email, String? password}) async {
    try {
      final response =
          await http.post(Uri.parse('https://dummyjson.com/auth/login'),
              body: jsonEncode(<String, dynamic>{
                "username": email,
                "password": password,
              }),
              headers: <String, String>{'Content-Type': 'application/json'});
      print(response.body);
      if (response.statusCode == 200) {
        final userResponse = Map<String, dynamic>.from(jsonDecode(response.body));
        userModel.value = UserModel.fromJson(userResponse);
        pageRoute(userResponse['token']);

      }
    } catch (e) {}
  }

  void pageRoute(String token) async {
    // Here we store value or token inside shared preferences.
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", token);
    Get.offAll(() => SecondScreenPref());
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = await pref.getString('login');
    if (val != null) {
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoard()));
      Get.offAll(() => SecondScreenPref());
    }
  }
}
