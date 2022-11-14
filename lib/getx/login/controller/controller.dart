import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../view/second_screen.dart';

class Controller extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void login({String? email, String? password}) async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(Uri.parse('https://reqres.in/api/login'),
          body: ({
            "email": emailController.text,
            "password": passwordController.text
          }));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print(body);
        pageRoute(body['token']);
      }
    }
  }

  void pageRoute(String token) async {
    // Here we store value or token inside shared preferences.
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", token);
    Get.offAll(() => SecondScreen());
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = await pref.getString('login');
    if (val != null) {
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoard()));
      Get.offAll(() => SecondScreen());
    }
  }
}
