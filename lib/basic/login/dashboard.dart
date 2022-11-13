import 'package:flutter/material.dart';
import 'package:login_register_flutter/basic/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String token = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("login")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: Center(
              child: Column(
            children: [
              Text('Welcome User'),
              const SizedBox(
                height: 15,
              ),
              Text('Your Token: ${token}'),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
                icon: Icon(Icons.logout),
                label: Text("Logout"),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
