// Flutter imports:
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// Package imports:
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// Project imports:

import '../../../../infrastructure/fb_services/auth/auth.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../../../helpers/widgets/registration_and_login/bacground_waves_thene.dart';
import '../../registration/widgets/custom_pin_put.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final globalController = Get.find<GlobalController>();
  late String number;

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    return GestureDetector(
      onTap: globalController.unFocuseNode,
      child: Scaffold(
        /* backgroundColor: Colors.grey, */
        body: SafeArea(
          child: SingleChildScrollView(
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
                            'assets/images/authorization_screen/online_tribes_logo.png',
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
                      child: Column(
                        children: [
                          verticalSpaceSmall,
                          phoneCustomInput(),
                          verticalSpaceLarge,
                          GetBuilder<LoginController>(
                            builder: (value) {
                              return Visibility(
                                visible: value.isVeryficationScreen,
                                child: CustomPinPut(
                                    smsPinCode: controller.smsCodeController),
                              );
                            },
                          ),
                          GetBuilder<LoginController>(
                            builder: (value) {
                              return Column(
                                children: [


                                  SizedBox(
                                    height: value.isVeryficationScreen ? 60 : 0,
                                  ),
                                  SlimRoundedButton(
                                    backgroundColour: AppColors.primaryColor,
                                    title: value.isVeryficationScreen
                                        ? 'Verify SMS code'
                                        : 'Register',
                                    textColor: AppColors.whiteColor,
                                    onPress: () async {
                                      if (!controller.isVeryficationScreen) {
                                        controller.phoneController.text =
                                            number;
                                        await controller.verifyPhoneNumber();
                                      } else {
                                        await controller
                                            .signInWithPhoneNumber();
                                      }
                                    }, //creating account
                                  ),
                                  Visibility(
                                    visible: !value.isVeryficationScreen,
                                    child: Column(
                                      children: [
                                        verticalSpaceMedium,
                                        Text(' Or ', style: smallBoldGrey),
                                        verticalSpaceTiny,
                                        InkWell(
                                          onTap: () async {
                                            Auth().signInWithGoogle();
                                          },
                                          child: globalController
                                                  .isLoadingVisible
                                              ? const CircularProgressIndicator()
                                              : SizedBox(
                                                  height: 60,
                                                  width: 250,
                                                  child: Image.asset(
                                                    'assets/images/authorization_screen/google_sign.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Neumorphic phoneCustomInput() {
    return Neumorphic(
      style: NeumorphicStyle(
          depth: 10,
          shadowDarkColor: AppColors.primaryColor,
          color: Colors.transparent,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber value) {
            number = value.phoneNumber!;
          },
          selectorConfig: const SelectorConfig(
              setSelectorButtonAsPrefixIcon: true,
              selectorType: PhoneInputSelectorType.DIALOG,
              trailingSpace: true),
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          textFieldController: controller.phoneController,
          formatInput: false,
          textStyle: smallBold,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          inputDecoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Phone Number',
          ),
        ),
      ),
    );
  }
}
