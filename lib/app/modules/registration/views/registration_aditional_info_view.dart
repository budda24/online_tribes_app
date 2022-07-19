import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_upload_video_view.dart';
import 'package:flutter_application_1/app/modules/registration/widgets/neumorphic_circle_background.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

import '../widgets/time_to_invest_slider.dart';
import 'registration_upload_video_view.dart';

class RegistrationAditionalView extends GetView<RegistrationController> {
  final _formKey = GlobalKey<FormState>();

  final globalController = Get.find<GlobalController>();
  final cameraController = Get.find<CameraController>();

  RegistrationAditionalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: globalController.unFocuseNode,
      child: Scaffold(
        backgroundColor: kMainColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 30, left: 30, right: 30, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeumorphicCircleBackground(
                      child: MainCirclePhoto.file(
                        imageSize: 100,
                          screeanheight: 300.h,
                          screeanwidth: 250.w,
                          file: cameraController.pickedPhoto!),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      controller: controller.lifeMottoController,
                      validate: (value) =>
                          controller.validateUser(value: value, lenght: 200),
                      hintText: 'The Life Motto',
                      maxline: 6,
                      minLine: 1,
                      height: 130.h,
                      width: 500.w,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      controller: controller.hobby1Controller,
                      validate: (value) =>
                          controller.validateUser(value: value, lenght: 50),
                      textInputAction: TextInputAction.next,
                      hintText: 'Hobby 1',
                      maxline: 1,
                      minLine: 1,
                      height: 50.h,
                      width: 500.w,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      controller: controller.hobby2Controller,
                      validate: (value) =>
                          controller.validateUser(value: value, lenght: 50),
                      textInputAction: TextInputAction.next,
                      hintText: 'Hobby 2',
                      maxline: 1,
                      minLine: 1,
                      height: 50.h,
                      width: 500.w,
                    ),
                    verticalSpaceMedium,
                    Stack(
                      children: [
                        const Positioned(
                            top: 65,
                            left: 100,
                            child: Text(
                              'Time to invest',
                              style: kHintStyle,
                            )),
                        TimeToInvestSlider(sliderValue: controller.sliderValue),
                      ],
                    ),
                    verticalSpaceTiny,
                    SlimRoundedButton(
                      onPress: () {
                        controller.closeKeyboard();
                        if (_formKey.currentState!.validate()) {
                          /* Get.to(() => ProfileView()); */
                          Get.to(RegistrationUploadVideoView());
                        }
                      },
                      backgroundColour: kColorWhite,
                      title: 'Continue',
                      textColor: kTextColorDarkGrey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
