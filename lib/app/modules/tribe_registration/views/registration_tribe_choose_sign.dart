// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Project imports:

import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/widgets/online_tribes/general/main_button.dart';
import '../../../helpers/theme/main_constants.dart';
import '../../profile/widgets/bacground_rounded_container.dart';
import '../controllers/tribe_registration_controller.dart';
import '../widgets/tribal_sign_picker.dart';
import '../widgets/tribe_sign_with_pointer.dart';
import 'registration_tribe_description.dart';

class RegistrationTribeChooseSign extends GetView<TribeRegistrationController> {
  /* final tribeRegistrationController = Get.put(TribeRegistrationController()); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: 0.2.sh,
            child: Padding(
              padding: EdgeInsets.only(top: 50.h, right: 25.w, left: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30.w,
                  ),
                   Text(
                    'Choose Tribal Sign',
                    style: kName,
                  ),
                ],
              ),
            ),
          ),
          BacgroundRoundedContainer(
            child: Column(
              children: [
                SizedBox(
                  height: 530,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 120.h,
                    ),
                    children: [
                      ...controller.tribesSigns
                          .map((element) => TribeSignWithPointer(
                                imagePath: element['imagePath'],
                                index: element['index'],
                              ))
                          .toList(),
                      TribalSignPicker(),
                    ],
                  ),
                ),
                SlimRoundedButton(
                  onPress: () {
                    Get.to(RegistrationTribeDescription());
                  },
                  backgroundColour: kColorWhite,
                  title: 'Continue',
                  textColor: kTextColorDarkGrey,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
