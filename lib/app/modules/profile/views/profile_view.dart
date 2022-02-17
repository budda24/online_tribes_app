import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_bars.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackArrow(
        title: Text(
          'Profile view',
          style: headingBoldStyle,
        ),
      ),
      body: Center(
        child: Text(
          'ProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
