import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/video_player.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/controllers/tribe_registration_controller.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/widgets/rounded_input_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/helpers/main_constants.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_viewer/domain/bloc/controller.dart';

import '../../../helpers/widgets/online_tribes/main_button.dart';

class RegistrationTribeCreationTribe extends StatelessWidget {
  // final tribeRegistrationController = Get.put(TribeRegistrationController());
  final tribeRegistrationController = Get.find<TribeRegistrationController>();
  final videoController = Get.put(VideoViewerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: screenHeight(context) * 0.25,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h, right: 25.w, left: 25.w),
                    child: const Center(
                      child: Text(
                        'Create a Tribe',
                        style: kName,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: ScreenUtil().screenHeight * 0.65,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.r),
                        topLeft: Radius.circular(30.r),
                      )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomVideoPlayer(
                          videoSrc: 'videoSrc',
                          videoController: videoController,
                        ),
                        RoundedInputContainer(
                          height: 60,
                          hintText: 'Name',
                          textController:
                              tribeRegistrationController.nameController,
                          validate: (value) => tribeRegistrationController
                              .validateTribe(value: value, lenght: 50),
                        ),
                        RoundedInputContainer(
                          height: 60,
                          hintText: 'Type',
                          textController:
                              tribeRegistrationController.typeController,
                          validate: (value) => tribeRegistrationController
                              .validateTribe(value: value, lenght: 50),
                        ),
                        RoundedInputContainer(
                          height: 120,
                          hintText: 'Description',
                          textController:
                              tribeRegistrationController.descritionController,
                          validate: (value) => tribeRegistrationController
                              .validateTribe(value: value, lenght: 1500),
                        ),
                        RoundedInputContainer(
                          height: 80,
                          hintText: 'Purpose',
                          textController:
                              tribeRegistrationController.purpouseController,
                          validate: (value) => tribeRegistrationController
                              .validateTribe(value: value, lenght: 500),
                        ),
                        RoundedInputContainer(
                          height: 80,
                          hintText: 'Goals',
                          textController:
                              tribeRegistrationController.goalsController,
                          validate: (value) => tribeRegistrationController
                              .validateTribe(value: value, lenght: 500),
                        ),
                        RoundedInputContainer(
                          height: 80,
                          hintText: 'Motto of Tribe',
                          textController:
                              tribeRegistrationController.mottoOfTribeController,
                          validate: (value) => tribeRegistrationController
                              .validateTribe(value: value, lenght: 250),
                        ),
                        RoundedInputContainer(
                          height: 60,
                          hintText: 'Weekly suggested TIME',
                          textController: tribeRegistrationController
                              .weeklySuggestedTimeController,
                          validate: (value) => tribeRegistrationController
                              .validateTribe(value: value, lenght: 200),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: AppColors.whiteColor,
                  height: ScreenUtil().screenHeight * 0.1,
                  width: double.infinity,
                  child: Center(
                    child: SlimRoundedButton(
                      backgroundColour: AppColors.actionColor,
                      title: 'Continue',
                      textColor: AppColors.whiteColor,
                      onPress: () {},
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              left: 125,
              top: 120,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: AppColors.primaryColor,
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: AppColors.greyColor,
                  child: Image.asset(cArtistTribe),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
