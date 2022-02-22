import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/main_constants.dart';
import 'package:flutter_application_1/app/helpers/theme/app_bars.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/bacground_waves_thene.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/main_button.dart';
import 'package:flutter_application_1/app/modules/authorization/controllers/resetPassword_controller.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

class RestPasswordView extends GetView {
  @override
  final controller = Get.put(ResetPasswordController());
  final globalController = Get.find<GlobalController>();

  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return GestureDetector(
      onTap:globalController.unFocuseNode,
      child: Scaffold(
        appBar: AppBarBackArrow(
          title: Text(
            'Forgot password',
            style: headingBoldStyle,
          ),
        ),
        body: Column(
          children: [
            GreenWaves2(
              screeanheight: 0.2.sh,
            ),
            Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 0.3.sh),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: controller.emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter a product name eg. pension',
                        hintStyle: TextStyle(fontSize: 16.sp),
                        contentPadding: EdgeInsets.all(16.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.28.sh,
                ),
                SlimRoundedButton(
                  title: 'Subbmit',
                  textColor: AppColors.whiteColor,
                  onPress: () {
                    controller.reset();
                  },
                  backgroundColour: AppColors.primaryColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Don't have an account",style: smallTextStyle,),
                  TextButton(
                    onPressed: () async {
                      Get.toNamed(Routes.REGISTRATION);
                    },
                    child: Text('SIGN UP'),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
