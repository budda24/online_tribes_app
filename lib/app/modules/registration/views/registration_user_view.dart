import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/camea_controller.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field_shadow.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/main_button.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

class RegistrationBasicInfoView extends GetView<RegistrationController> {
  final globalController = Get.find<GlobalController>();
  final cameraController = Get.put(CameraController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: globalController.unFocuseNode,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kMainColor,
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                top: 170,
                right: 0,
                child: Container(
                  width: 411.w,
                  height: 640.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: AppColors.whiteColor,
                  ),
                  child: Form(
                    /* key: controller.formKey, */
                    child: Container(
                      margin: EdgeInsets.only(top: 50.h),
                      padding: EdgeInsets.symmetric(horizontal: 41.w),
                      child: Column(
                        children: [
                          verticalSpaceMedium,
                          CustomTextFormFieldShadow(
                              hintText: 'Name',
                              textInputType: TextInputType.text,
                              controller: controller.signUpTribalNameController,
                              maxLenght: 50),
                          verticalSpaceMedium,
                          CustomTextFormFieldShadow(
                              hintText: 'Yor Phone No.',
                              textInputType: TextInputType.phone,
                              controller: controller.signUpPhoneController,
                              maxLenght: 50),
                          verticalSpaceMedium,
                          GetBuilder<RegistrationController>(
                            builder: (value) {
                              return Visibility(
                                visible: value.isSMSCodeHere,
                                child: CustomTextFormFieldShadow(
                                    hintText: 'OtpCode',
                                    textInputType: TextInputType.number,
                                    isPassword: true,
                                    controller: controller.smsCodeController,
                                    maxLenght: 50),
                              );
                            },
                          ),
                          verticalSpaceMedium,
                          CustomTextFormFieldShadow(
                              hintText: 'Confirm Password',
                              textInputType: TextInputType.text,
                              isPassword: true,
                              controller:
                                  controller.signUpPasswordConfirmController,
                              maxLenght: 50),
                          verticalSpaceLarge,
                          GetBuilder<RegistrationController>(
                            builder: (value) {
                              return SlimRoundedButton(
                                backgroundColour: AppColors.primaryColor,
                                title: value.isSMSCodeHere
                                    ? 'Verify SMS code'
                                    : 'Register',
                                textColor: AppColors.whiteColor,
                                onPress: () {
                                  if (!controller.isSMSCodeHere) {
                                    controller.registerUserByPhone(
                                        mobileNumber: controller
                                            .signUpPhoneController.text);
                                  } else {
                                    controller.verifySMSCode();
                                  }

                                  // controller.createUser();
                                  /* Get.to(RegistrationDescriptionView()); */
                                }, //creating account
                              );
                            },
                          ),
                          verticalSpaceSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text('OR', style: smallBold),
                                  const Text('Connect with'),
                                ],
                              ),
                              SizedBox(
                                height: 80.h,
                                width: 80.w,
                                child: Image.asset(
                                    'assets/images/authorization_screen/google_icon.png'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: smallTextStyle,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.offAllNamed(Routes.LOGIN);
                                }, //go to sign in
                                child:
                                    Text('SIGN IN', style: boldSmallTextStyle),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: 70,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: GetBuilder(
                    init: cameraController,
                    builder: (CameraController cameraCon) => Column(children: [
                      cameraCon.profileIimage == null
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
                                      return Card(
                                        color: AppColors.textFieldFill,
                                        child: Container(
                                          height: 100,
                                          color: AppColors.textFieldFill,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      await cameraController
                                                          .getImageGallery();
                                                    },
                                                    icon: Icon(
                                                      Icons.photo_album,
                                                      size: 50.h,
                                                    ),
                                                  ),
                                                  verticalSpaceTiny,
                                                  Text(
                                                    '   Gallery',
                                                    style: headingBoldStyle,
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      await cameraController
                                                          .getImageCamera();
                                                    },
                                                    icon: Icon(
                                                      Icons.camera,
                                                      size: 50.h,
                                                    ),
                                                  ),
                                                  verticalSpaceTiny,
                                                  Text(
                                                    '   Camera',
                                                    style: headingBoldStyle,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                            )
                          : MainCirclePhoto.file(
                              screeanheight: 300.h,
                              screeanwidth: 250.w,
                              file: cameraCon.profileIimage!),
                    ]),
                  ),
                ),
              ),
              /* const Positioned.fill(
                top: 10,
                left: 30,
                child: Align(
                  alignment: Alignment.topCenter,
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
