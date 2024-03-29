// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';

// Project imports:

import '../../../controllers/global_controler.dart';

import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/widgets/online_tribes/auth/phone_number_input.dart';
import '../../../helpers/widgets/online_tribes/general/main_button.dart';
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/widgets/registration_and_login/bacground_waves_thene.dart';

import '../../user_registration/widgets/custom_pin_put.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final globalController = Get.find<GlobalController>();
  PhoneNumber? numberToAuth;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    return GestureDetector(
      onTap: globalController.unFocuseNode,
      child: Scaffold(
        body: SafeArea(
          child: Obx(
            () => globalController.isLoadingVisible.value
                ? spinkit
                : SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                            children: [
                              GreenWaves1(screeanheight: 635.h),
                              Center(
                                child: Column(
                                  children: [
                                    verticalSpace25,
                                    Image.asset(
                                      'assets/images/authorization_screen/logo/xxxhdpi.png',
                                      fit: BoxFit.fill,
                                    ),
                                    Text('Welcome back, \n        fellas!',
                                        style: lableWhite)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 41.w),
                                child: Column(children: [
                                  verticalSpace20,
                                  Form(
                                    key: _formKey,
                                    child: PhoneNumberInput(
                                      /* initialNumber: controller.numberToVerify, */
                                      controller: controller,
                                      isEnabled: !controller
                                          .isVeryficationScreen.value,
                                    ),
                                  ),
                                  verticalSpace50,
                                  Visibility(
                                      visible:
                                          controller.isVeryficationScreen.value,
                                      child: CustomPinPut(
                                          smsPinCode:
                                              controller.smsCodeController)),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: controller
                                                .isVeryficationScreen.value
                                            ? 60
                                            : 0,
                                      ),
                                      SlimRoundedButton(
                                        backgroundColour:
                                            AppColors.primaryColor,
                                        title: controller
                                                .isVeryficationScreen.value
                                            ? 'Verify SMS'
                                            : 'Login \n Register',
                                        textColor: AppColors.white,
                                        onPress: () async {
                                          _formKey.currentState!.save();
                                          if (!controller
                                                  .isVeryficationScreen.value &&
                                              controller.isNumberChosen) {
                                            await controller
                                                .verifyPhoneNumber();
                                          } else if (controller
                                              .isNumberChosen) {
                                            globalController.unFocuseNode();
                                            await controller
                                                .signInWithPhoneNumber();
                                          }
                                          //creating account
                                        },
                                      ),
                                      Visibility(
                                        visible: !controller
                                            .isVeryficationScreen.value,
                                        child: Column(
                                          children: [
                                            verticalSpace25,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Divider(
                                                    thickness: 2,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Text(
                                                    'OR',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Divider(
                                                  thickness: 2,
                                                  color: Colors.grey.shade500,
                                                )),
                                              ],
                                            ),
                                            verticalSpace10,
                                            InkWell(
                                              onTap: () async {
                                                await controller
                                                    .signInWithGoogle();
                                              },
                                              child: SizedBox(
                                                height: 60.h,
                                                width: 250.w,
                                                child: Image.asset(
                                                  'assets/images/authorization_screen/google/xxxhdpi.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ]),
                  ),
          ),
        ),
      ),
    );
  }
}
