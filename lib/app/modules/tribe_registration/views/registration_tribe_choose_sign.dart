// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Project imports:

import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
import '../../profile/widgets/bacground_rounded_container.dart';
import '../controllers/tribe_registration_controller.dart';
import '../widgets/tribal_sign_picker.dart';
import '../widgets/tribe_sign_with_pointer.dart';
import 'registration_tribe_create_tribe.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 30.w,
                  ),
                  const Text(
                    'Choose',
                    style: kName,
                  ),
                  Obx(
                    () => controller.isSignChosen.value
                        ? InkWell(
                            onTap: () {
                              controller.choosenSignIndex!.value != -1
                                  ? Get.to(RegistrationTribeCreationTribe())
                                  : null;
                            },
                            child: SizedBox(
                              height: 30.h,
                              width: 40.w,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(cConfirmSign),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  )
                ],
              ),
            ),
          ),
          BacgroundRoundedContainer(
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
                TribalSignPicker()
              ],
            ),
          )
        ],
      ),
    );
  }
}
