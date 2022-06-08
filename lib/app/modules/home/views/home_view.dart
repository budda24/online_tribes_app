import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../../../infrastructure/fb_services/auth/auth.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.blue,
          onPressed: () async {
            await auth.signOut();
            Get.offAllNamed(Routes.LOGIN);
          },
          splashColor: Colors.blueGrey,
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
