// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/registration/registration_template.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

// Project imports:
import '../../../../infrastructure/native_functions/time_converting_services.dart';
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/widgets/online_tribes/registration/form_field.dart';
import '../../../helpers/widgets/online_tribes/registration/time_range_button.dart';
import '../controllers/tribe_registration_controller.dart';

class RegistrationTribeAditionalInfo extends GetView {
  final tribeRegistrationController = Get.find<TribeRegistrationController>();
  final globalController = Get.find<GlobalController>();
  final videoController = Get.find<VideoViewerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: RegistrationTemplate(
        topElementsMargin: 100,
        buttonCallBack: () {},
        centerWidget: Column(
          children: [
            verticalSpaceMedium,
            CustomTextField(
              textInputAction: TextInputAction.next,
              controller: tribeRegistrationController.nameController,
              /* validate: (value) =>
                  controller.validateUser(value: value, lenght: 200), */
              hintText: 'Tribe Name',
              maxline: 2,
              minLine: 1,
              height: 130.h,
              width: 500.w,
            ),
            verticalSpaceMedium,
            CustomTextField(
              textInputAction: TextInputAction.next,
              controller: tribeRegistrationController.nameController,
              /* validate: (value) =>
                  controller.validateUser(value: value, lenght: 200), */
              hintText: 'Tribe type',
              maxline: 2,
              minLine: 1,
              height: 130.h,
              width: 500.w,
            ),
            verticalSpaceMedium,
            AvailableTimeButton(onPressed: () async {
              tribeRegistrationController.availableTime =
                  await TimeCovertingServices()
                      .getCustomTimeRangePicker(context);
            })
          ],
        ),
      ),
    );
  }
}
/*
            RoundedInputContainer(
              height: 60,
              hintText: 'Type',
              textController: tribeRegistrationController.typeController,
              validate: (value) =>
                  globalController.validateInputs(value: value, lenght: 50),
            ),
            RoundedInputContainer(
              height: 80,
              hintText: 'Purpose',
              textController: tribeRegistrationController.purpouseController,
              validate: (value) =>
                  globalController.validateInputs(value: value, lenght: 500),
            ),
            RoundedInputContainer(
              height: 80,
              hintText: 'Goals',
              textController: tribeRegistrationController.goalsController,
              validate: (value) =>
                  globalController.validateInputs(value: value, lenght: 500),
            ),
            RoundedInputContainer(
              height: 80,
              hintText: 'Motto of Tribe',
              textController:
                  tribeRegistrationController.mottoOfTribeController,
              validate: (value) =>
                  globalController.validateInputs(value: value, lenght: 250),
            ),
            RoundedInputContainer(
              height: 60,
              hintText: 'Weekly suggested TIME',
              textController:
                  tribeRegistrationController.weeklySuggestedTimeController,
              validate: (value) =>
                  globalController.validateInputs(value: value, lenght: 200),
            ), */
