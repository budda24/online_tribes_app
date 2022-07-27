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
import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
import '../../../helpers/widgets/registration_and_login/bacground_waves_thene.dart';
import '../../registration/widgets/custom_pin_put.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final globalController = Get.find<GlobalController>();
  PhoneNumber? numberToAuth;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('${1.sh} < $tabletSize');
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
                                    verticalSpaceMedium,
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
                                  verticalSpaceSmall,
                                  Form(
                                    key: _formKey,
                                    child: PhoneNumberInput(
                                      controller: controller,
                                    ),
                                  ),
                                  verticalSpaceLarge,
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
                                            ? 'Verify SMS code'
                                            : 'Login',
                                        textColor: AppColors.whiteColor,
                                        onPress: () async {
                                          if (!controller
                                              .isVeryficationScreen.value) {
                                            _formKey.currentState!.save();
                                            await controller
                                                .verifyPhoneNumber();
                                          } else {
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
                                            verticalSpaceMedium,
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
                                            verticalSpaceTiny,
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
