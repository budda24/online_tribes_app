import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/controllers/tribe_registration_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/helpers/main_constants.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/tribe_sign_choooser.dart';
import 'registration_tribe_create_tribe.dart';

class RegistrationTribeChooseSign extends StatelessWidget {
  final tribeRegistrationController = Get.put(TribeRegistrationController());

  List<Widget> triresSignsForChoose = [
    TribeSignChooser(imagePath: cMotheringTribe, index: 0),
    TribeSignChooser(imagePath: cMusicalTribe, index: 1),
    TribeSignChooser(imagePath: cTravellerTribe, index: 2),
    TribeSignChooser(imagePath: cArtistTribe, index: 3),
    TribeSignChooser(imagePath: cBussinessTribe, index: 4),
    TribeSignChooser(imagePath: cWriteringTribe, index: 5),
    TribeSignChooser(imagePath: cIllnessTribe, index: 6),
    TribeSignChooser(imagePath: cAddCustomSign, index: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: ScreenUtil().screenHeight * 0.2,
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
                  InkWell(
                    onTap: () {
                      tribeRegistrationController.choosenIndex!.value < 8
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
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.r),
                  topLeft: Radius.circular(30.r),
                )),
            height: ScreenUtil().screenHeight * 0.8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 100.h,
                ),
                children: [...triresSignsForChoose],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
