// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

// Project imports:
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/widgets/online_tribes/general/main_button.dart';
import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../controllers/tribe_registration_controller.dart';
import '../widgets/rounded_input_container.dart';

class RegistrationTribeCreationTribe extends GetView {
  final tribeRegistrationController = Get.put(TribeRegistrationController());
  final globalController = Get.find<GlobalController>();
  final videoController = Get.put(VideoViewerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: ProfileTemplate(
          fields: [
            RoundedInputContainer(
              height: 120,
              hintText: 'Description',
              textController: tribeRegistrationController.descritionController,
              validate: (value) =>
                  globalController.validateInputs(value: value, lenght: 1500),
            ),
            RoundedInputContainer(
              height: 60,
              hintText: 'Name',
              textController: tribeRegistrationController.nameController,
              validate: (value) =>
                  globalController.validateInputs(value: value, lenght: 50),
            ),
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
            ),
          ],
          title: const Text(
            'Create a Tribe',
            style: kName,
          ),
          profileVideoSrc: '',
          button: SlimRoundedButton(
            backgroundColour: AppColors.actionColor,
            title: 'Continue',
            textColor: AppColors.whiteColor,
            onPress: () {},
          ),
          profileImage: Image.asset(cArtistTribeSign),
        ),
      ),
    );
  }
}
