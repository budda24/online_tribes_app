import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/main_constants.dart';
import 'package:flutter_application_1/app/helpers/theme/app_bars.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/main_button.dart';
import 'package:flutter_application_1/app/modules/authorization/controllers/resetPassword_controller.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

class RestPasswordView extends GetView {
  @override
  final controller = Get.put(ResetPasswordController());

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackArrow(
        title: Text(
          'Forgot password',
          style: headingBoldStyle,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 300),
            child: Column(
              children: [
                TextField(
                  textAlign: TextAlign.center,
                  controller: controller.emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter a product name eg. pension',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    fillColor: AppColors.primaryColor,
                  ),
                ),
                SlimRoundedButton(
                  title: 'Subbmit',
                  textColor: AppColors.whiteColor,
                  onPress: () {
                    controller.reset();
                  },
                  backgroundColour: AppColors.primaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
