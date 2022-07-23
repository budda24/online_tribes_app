import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/views/registration_tribe_choose_sign.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/widgets/background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TribeRegistrationStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrangeColor,
      body: SafeArea(
          child: Background(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              Text(
                'A NEW WILLAGE AWAITS YOU',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 430.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Get.to(RegistrationTribeChooseSign());
                    },
                    minWidth: 117.w,
                    color: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Text(
                      'Create Tribe',
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          'My profile',
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.whiteColor,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
      /* ), */
    );
  }
}
