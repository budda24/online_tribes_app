import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


import 'app_colors.dart';
class AppBarBackArrow extends StatelessWidget {
  const AppBarBackArrow({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      );
  }
}