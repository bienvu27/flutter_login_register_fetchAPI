import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller_second_screen_pref.dart';


class SecondScreenPref extends StatelessWidget {
  const SecondScreenPref({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerSecondScreenPref>(
      init: ControllerSecondScreenPref(),
      builder: (controller) {
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
                  Text('Your Token: ${controller.token}'),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      controller.logOut();
                    },
                    icon: Icon(Icons.logout),
                    label: Text("Logout"),
                  ),
                ],
              )),
            ),
          ),
        );
      },
    );
  }
}
