// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/theme/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../tribe_registration/widgets/background.dart';

class TribeRegistrationChoice extends StatelessWidget {
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
                      Get.toNamed(Routes.TRIBE_REGISTRATION);
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
                    onTap: () {
                      Get.offAllNamed(Routes.PROFILE);
                    },
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
