// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/form_field_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../../../helpers/widgets/online_tribes/custom_Checkbox.dart';
import '../../../helpers/widgets/online_tribes/login_icons.dart';
import '../../../helpers/widgets/online_tribes/bacground_waves_thene.dart';
import '../controllers/login_controller.dart';
import '../../../helpers/assets/networkIng_images.dart';
import '../../registration/views/registration_desrription_view.dart';
import '../../../helpers/widgets/online_tribes/form_field.dart';
import 'rest_password_view.dart';

class LoginView extends GetView<LoginController> {
  final controller = Get.put(LoginController());

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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  GreenWaves1(screeanheight: 735.h),
                  Center(
                    child: Container(
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
                          TextFormField(
                            controller: controller.emailController,
                            maxLength: 320,
                            autofillHints: [AutofillHints.email],
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: true,
                            style: outlineInputTextFormFieldHintStyle,
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          horizontalSpaceTiny,
                          TextFormField(
                            controller: controller.passwordController,
                            maxLength: 120,
                            keyboardType: TextInputType.text,
                            obscuringCharacter: '*',
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            style: outlineInputTextFormFieldHintStyle,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
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
                        Text(
                          'Remember me',
                          style: kTextCheckBox,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 123),
                            child: TextButton(
                              child: Text('Forgot Password?',
                                  style: kTextCheckBox),
                              onPressed: () {
                                Get.to(RestPasswordView());
                              },
                            ))
                      ],
                    ),
                    /* SizedBox(
                      height: 16.h,
                    ), */
                    Center(
                      child: SlimRoundedButton(
                        onPress: controller.performSignin,
                        title: 'LOGIN',
                        backgroundColour: kMainColor,
                        textColor: kColorWhite,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(/*right: screeanwidth * 0.04*/),
                            child: LoginIcons.socialButtonCircle(
                                facebookColor, FontAwesomeIcons.facebookF,
                                iconColor: Colors.white, onTap: () {}),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(/*right: screeanwidth * 0.04*/),
                            child: LoginIcons.socialButtonCircle(
                                googleColor, FontAwesomeIcons.googlePlusG,
                                iconColor: Colors.white, onTap: () {}),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Get.toNamed(Routes.REGISTRATION);
                      },
                      child: Text('SIGN UP'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
