import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_register_flutter/basic/login/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    // here we check if alrealy login or credential alrealy available or not
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = await pref.getString('login');
    if (val != null) {
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoard()));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => DashBoard()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: emailController,
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
                  controller: passwordController,
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
                    login();
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
  }

  void login() async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(Uri.parse('https://reqres.in/api/login'),
          body: ({
            "email": emailController.text,
            "password": passwordController.text
          }));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Token: ${body['token']}")));
        print("login Token" + response.toString());
        pageRoute(body['token']);

      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
        print('Invalid Credentials');
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Blank Value Found")));
    }
  }

  void pageRoute(String token) async {
    // Here we store value or token inside shared preferences.
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", token);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashBoard()), (route) => false);
  }
}
