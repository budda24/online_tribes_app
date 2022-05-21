// Flutter imports:
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:clay_containers/clay_containers.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:

import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/form_field_shadow.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../../../helpers/widgets/online_tribes/custom_Checkbox.dart';

import '../../../helpers/widgets/registration_and_login/bacground_waves_thene.dart';
import '../controllers/login_controller.dart';
import '../../../helpers/assets/networkIng_images.dart';

import '../../../helpers/widgets/online_tribes/login_services_Icon.dart';
import 'rest_password_view.dart';

class LoginView extends GetView<LoginController> {
  final globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(411, 809),
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
                    GreenWaves1(screeanheight: 735.h),
                    Center(
                      child: SizedBox(
                        height: 350.h,
                        width: 250.w,
                        /*padding: EdgeInsets.all(screeanheight*01),
                  margin: EdgeInsets.only(top: screeanheight * 0.025),*/
                        child: Center(
                          child: Image.network(
                            AssetsUrl.logo411x600,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 41.w),
                        child: Column(
                          children: [
                            CustomTextFormFieldShadow(
                              controller: controller.phoneController,
                              textInputType: TextInputType.phone,
                              hintText: 'Phone No.',
                              maxLenght: 30,
                            ),
                            verticalSpaceMedium,
                            CustomTextFormFieldShadow(
                              textInputType: TextInputType.text,
                              isPassword: true,
                              controller: controller.passwordController,
                              hintText: 'Password',
                              maxLenght: 120,
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceTiny,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 41.w,
                            height: 52.h,
                          ),
                          CustomCheckbox(
                            isChecked: controller.isRememberMe,
                            callBack: controller.toggleRememberMe,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          const Text(
                            'Remember me',
                            style: kTextCheckBox,
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 123),
                              child: TextButton(
                                child: Text(
                                  'Forgot Password?',
                                  style: boldSmallTextStyle,
                                ),
                                onPressed: () {
                                  Get.to(RestPasswordView());
                                },
                              ))
                        ],
                      ),
                      /* SizedBox(
                        height: 16.h,
                      ), */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: SlimRoundedButton(
                              onPress: controller.performSignin,
                              title: 'Login',
                              backgroundColour: kMainColor,
                              textColor: kColorWhite,
                            ),
                          ),
                          Text(
                            'OR',
                            style: boldSmallTextStyle.copyWith(
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 80.h,
                            width: 80.w,
                            child: Image.asset(
                                'assets/images/authorization_screen/google_icon.png'),
                          )
                        ],
                      ),
                      verticalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Don\'t have an account?'),
                          SlimRoundedButton(
                              backgroundColour: AppColors.actionColor,
                              title: 'Sign Up',
                              textColor: Colors.white,
                              onPress: () {
                                Get.toNamed(Routes.REGISTRATION);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
