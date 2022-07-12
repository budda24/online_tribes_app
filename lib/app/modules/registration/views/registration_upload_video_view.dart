import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/main_button.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/fb_services/db_services/user_db_services.dart';
import '../../../controllers/camea_controller.dart';

import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../widgets/custom_photo_picker.dart';

class RegistrationUploadVideoView extends GetView {
  final cameraController = Get.find<CameraGetXController>();
  final registrationController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              GetBuilder(
                init: cameraController,
                builder: (CameraGetXController cameraCon) =>
                    cameraCon.image == null
                        ? InkWell(
                            child: MainCirclePhoto.icon(
                                screeanheight: 300.h,
                                screeanwidth: 250.w,
                                icon: Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 40,
                                  color: AppColors.whiteColor,
                                )),
                            onTap: () async {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomPhotoPicker(
                                        cameraController: cameraController);
                                  });
                            },
                          )
                        : MainCirclePhoto.file(
                            screeanheight: 300.h,
                            screeanwidth: 250.w,
                            file: cameraCon.image!),
              ),
              const Text(
                'Cornelius',
                style: kName,
              ),
              SizedBox(
                height: 40.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: AppColors.primaryColorWithOpacity40,
                ),
                width: double.infinity,
                height: 444.h,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 30, left: 30, right: 30, top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        'Upload your video',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      verticalSpaceMedium,
                      Image.asset(
                        'assets/images/authorization_screen/add_photo.png',
                        scale: 1.3,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Image.asset(
                        'assets/images/authorization_screen/upload_video.png',
                        scale: 1.3,
                      ),
                      SizedBox(
                        height: 45.h,
                      ),
                      SlimRoundedButton(
                          backgroundColour: AppColors.primaryColor,
                          title: 'Continue',
                          textColor: AppColors.whiteColor,
                          onPress: () async {
                            registrationController.userDB.email =
                                currentUser.email ?? 'email address not found';
                            registrationController.userDB.phoneNumber =
                                currentUser.phoneNumber ?? 'phone number not found';

                            registrationController.userDB.introVideoUrl =
                                'Test test http';
                            await UserDBServices()
                                .createUser(registrationController.userDB);
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
