import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:path/path.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

import '../widgets/custom_photo_picker.dart';
import 'registration_upload_video_view.dart';

class RegistrationAditionalView extends GetView<RegistrationController> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = Get.put(RegistrationController());
    final globalController = Get.find<GlobalController>();
    final cameraController = Get.find<CameraController>();

    return GestureDetector(
      onTap: globalController.unFocuseNode,
      child: Scaffold(
        backgroundColor: kMainColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 30, left: 30, right: 30, top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GetBuilder(
                          init: cameraController,
                          builder: (CameraController cameraCon) =>
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
                                              return CustomPhotoPicker(
                                                  cameraController:
                                                      cameraController);
                                            }).then((value) => controller.uploadProfilePicture());


                                      },
                                    )
                                  : MainCirclePhoto.file(
                                      screeanheight: 300.h,
                                      screeanwidth: 250.w,
                                      file: cameraCon.profileIimage!),
                        ),
                        const Text(
                          'Cornelius',
                          style: kName,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextField(
                          controller: controller.lifeMottoController,
                          validate: (value) => controller.userDBValidator(
                              value: value, lenght: 200),
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
                          controller: controller.hobbyController,
                          validate: (value) => controller.userDBValidator(
                              value: value, lenght: 50),
                          hintText: 'Hobby',
                          maxline: 2,
                          minLine: 1,
                          height: 60.h,
                          width: 500.w,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Obx(() => Row(
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 270,
                                  child: NeumorphicSlider(
                                    thumb: CircleAvatar(
                                      radius: 26.r,
                                      backgroundColor: AppColors.actionColor,
                                      child: CircleAvatar(
                                        radius: 24.r,
                                        backgroundColor: AppColors.whiteColor,
                                      ),
                                    ),
                                    height: 24,
                                    min: 1,
                                    max: 7,
                                    value: controller.sliderValue.value,
                                    onChanged: (value) {
                                      controller.sliderValue.value = value;
                                    },
                                    style: SliderStyle(
                                      accent: AppColors.actionColor,
                                      variant: AppColors.whiteColor,
                                      depth: 10,
                                      lightSource: LightSource.topLeft,
                                      border: NeumorphicBorder(
                                        color: AppColors.whiteColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                NeumorphicBackground(
                                  backendColor: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: NeumorphicText(
                                    controller.sliderValue.value
                                        .toStringAsFixed(0),
                                    textStyle: NeumorphicTextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.bold),
                                    style: NeumorphicStyle(
                                        color: AppColors.whiteColor),
                                  ),
                                ),
                              ],
                            )),
                        verticalSpaceMedium,
                        SlimRoundedButton(
                          onPress: () {
                            controller.closeKeyboard();
                            if (formKey.currentState!.validate()) {
                              controller.userDB.lifeMotto =
                                  controller.lifeMottoController.text;
                              controller.userDB.hobby =
                                  controller.hobbyController.text;
                              controller.userDB.timeToInvest =
                                  controller.sliderValue.value.toInt();

                              Get.to(() => RegistrationUploadVideoView());
                            }
                          },
                          backgroundColour: kColorWhite,
                          title: 'Continue',
                          textColor: kTextColorDarkGrey,
                          /* screenWidth: screeanwidth,
                                screenHeight: screeanheight */
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
