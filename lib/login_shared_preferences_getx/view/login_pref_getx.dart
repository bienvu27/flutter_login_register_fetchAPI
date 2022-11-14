import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';


class LoginPrefGetX extends StatelessWidget {
  const LoginPrefGetX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 35),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.password),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          controller.login(email: "kminchelle", password: "0lelplR");

                        },
                        icon: Icon(Icons.login),
                        label: Text("login"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
