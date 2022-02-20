import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/modules/authorization/controllers/login_controller.dart';
import 'package:flutter_application_1/app/modules/authorization/controllers/signup_controller.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_desrription_view.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:flutter_application_1/app/helpers/widgets/online_tribes/one_line_textField.dart';
import '../../../helpers/assets/networkIng_images.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../../../helpers/widgets/online_tribes/login_services_Icon.dart';
import 'package:flutter_application_1/app/helpers/theme/app_bars.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/main_button.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

class RegistrationBasicInfoView extends StatelessWidget {
  final controller = Get.find<LoginController>();
  final globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(411, 809),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return GestureDetector(
      onTap:globalController.unfoocuseNodes,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarBackArrow(
          title: Text(
            'Registration',
            style: headingBoldStyle,
          ),
        ),
        backgroundColor: kMainColor,
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            /* alignment: Alignment.center, */
            children: [
              Positioned(
                bottom: 0,
                child: SingleChildScrollView(
                  child: Container(
                    width: 411.w,
                    height: 680.h,
                    /* margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom ), */
                    child: Form(
                      child: Column(
                        children: [
                          verticalSpaceLarge,
                          OneLineTextField(
                            controller: controller.signUpTribalNameController,
                            onsaved: () {},
                            validator: () {},
                            lable: 'Tribal Name?',
                          ),
                          OneLineTextField(
                            controller: controller.signUpemailController,
                            onsaved: () {},
                            validator: () {},
                            lable: 'Yor Email Adress',
                          ),
                          OneLineTextField(
                            controller: controller.signUpPasswordController,
                            onsaved: () {},
                            validator: () {},
                            lable: 'Create Password',
                          ),
                          OneLineTextField(
                            controller: controller.signUpPasswordConfirmController,
                            onsaved: () {},
                            validator: () {},
                            lable: 'Confirm Password',
                          ),
                          verticalSpaceLarge,
                          SlimRoundedButton(
                            backgroundColour: AppColors.primaryColor,
                            title: 'Create',
                            textColor: AppColors.whiteColor,
                            onPress: () {
                              Get.to(RegistrationDescriptionView());
                            }, //creating account
                          ),
                          verticalSpaceSmall,
                          Text('OR'),
                          Text('Connect with'),
                          LoginServicesIcons(
                            onTapFaccebook: () {},
                            onTapGoogle: () {},
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
                                child: Text(
                                  'SIGN IN',
                                  style: boldSmallTextStyle.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                /* top: -10, */
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(children: [
                    Text(
                      'Sign Up',
                      style: headingBoldStyle,
                    ),
                    MainCirclePhoto.networking(
                        /* imagePathL: '', */
                        imagePathN:
                            'https://dsm01pap004files.storage.live.com/y4m_NLYDjl1WsO0m3Cc0jMZWBlY2GWMN0WSGoBjemVm6bZGdnJhsNEE-ece4G0QPUyH65WapVziK2Nhfzu8VinUIqVGqoqKFCpMjyip8CgmQS5SZz-Mzq5cvAnQpIkgKeWAOztb9rapynbJpm7sTzM66euz784RbPFVyl5NraciSiy6qGxXYJrHybz3YT8gY2aN?width=57&height=57&cropmode=none',
                        screeanheight: 300.h,
                        screeanwidth: 250.w),
                  ]),
                ),
              ),
              Positioned.fill(
                top: 10,
                left: 30,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: IconButton(
                    icon: Icon(
                      Icons.add_a_photo,
                      color: AppColors.greyColor,
                    ),
                    onPressed: () {}, //add profile photo
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
