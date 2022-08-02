import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/camea_controller.dart';
import '../../../../controllers/global_controler.dart';
import '../../../../modules/profile/widgets/bacground_rounded_container.dart';
import '../../../../modules/registration/controllers/registration_controller.dart';
import '../../../../modules/registration/widgets/neumorphic_circle_background.dart';
import '../../../theme/app_colors.dart';
import '../general/main_button.dart';
import '../general/main_constants.dart';
import 'custom_photo_picker.dart';

class RegistrationTemplate extends StatelessWidget {
  RegistrationTemplate({
    Key? key,
    required this.centerWidget,
    this.formKey,
    required this.buttonCallBack,
    this.title,
  }) : super(key: key);

  final GlobalKey<FormState>? formKey;

  @override
  final registrationController = Get.put(RegistrationController());
  final cameraController = Get.put(CameraController());
  final globalController = Get.find<GlobalController>();

  final Widget centerWidget;
  final VoidCallback buttonCallBack;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: globalController.unFocuseNode,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: 1.sh,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  child: BacgroundRoundedContainer(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 10),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: centerWidget,
                            ),
                            const SizedBox(
                              height: 41,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 125,
                  top: 65,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: AppColors.primaryColor,
                    child: GetBuilder(
                      init: cameraController,
                      builder: (CameraController cameraCon) => cameraCon
                                  .pickedPhoto ==
                              null
                          ? InkWell(
                              child: NeumorphicCircleBackground(
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundColor: AppColors.greyColor,
                                  child: Icon(
                                    Icons.add_a_photo_rounded,
                                    size: 40,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: AppColors.transparent,
                                    builder: (BuildContext context) {
                                      return CustomPhotoPicker();
                                    });
                              },
                            )
                          : CircleAvatar(
                              backgroundImage: cameraController.pickedPhoto ==
                                      null
                                  ? Image.asset(
                                          'assets/images/profile/bell.png')
                                      .image
                                  : Image.file(cameraController.pickedPhoto!)
                                      .image,
                              radius: 65,
                              backgroundColor: AppColors.greyColor,
                            ),
                    ),
                  ),
                ),
                Positioned(
                  top: 215,
                  child: Center(
                      child: title != null
                          ? Text(
                              title!,
                              style: const TextStyle(fontSize: 30),
                            )
                          : const SizedBox.shrink()),
                ),
                Positioned(
                  bottom: 30,
                  child: SlimRoundedButton(
                    onPress: buttonCallBack,
                    backgroundColour: kColorWhite,
                    title: 'Continue',
                    textColor: kTextColorDarkGrey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}