import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/main_constants.dart';
import '../../../../../helpers/theme/text_styles.dart';
import '../../../../../helpers/theme/ui_helpers.dart';
import '../../../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../../../../user_profile/widgets/rounded_container.dart';
import '../../../../user_profile/widgets/rounded_expanded_container.dart';
import '../../../../user_profile/widgets/video_player.dart';

import '../controllers/tribe_profile_controller.dart';

class TribeProfileView extends GetView<TribeProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: GetBuilder<TribeProfileController>(builder: (getController) {
          return ProfileTemplate(
            videoPlayer: GetBuilder<TribeProfileController>(
              builder: (builderController) =>
                  builderController.profileVideoSrc != ''
                      ? builderController.videoController != null
                          ? CustomVideoPlayer.network(
                              videoSrc: builderController.profileVideoSrc,
                              videoController:
                                  builderController.videoController)
                          : const SizedBox.shrink()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            spinkit,
                            const SizedBox(height: 20),
                            const Text('Loading'),
                          ],
                        ),
            ),
            profileImage: Image.network(controller.profilePhotoUrl),
            rigtTopIconColumn: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Log Out',
                    style: greenTitle,
                  ),
                  InkWell(
                    onTap: () {
                      //TODO LOGOUT
                      /* profileController.logout(); */
                    },
                    child: Icon(
                      Icons.logout,
                      size: 50,
                      color: AppColors.actionColor,
                    ),
                  ),
                ]),
            /* videoController: getController.videoTribeController, */
            title: const SizedBox.shrink(),
            /* profileVideoSrc: getController.profileVideo, */
            fields: [
              verticalSpaceSmall,
              Text(
                'Availability',
                style: tribalFontLable,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " time",
                    style: tribalFontLableRed,
                  ),
                  Text(
                    "-",
                    style: tribalFontLableRed,
                  ),
                  Text(
                    " time",
                    style: tribalFontLableRed,
                  ),
                ],
              ),
              const RoundedExpandedContainer(
                lable: 'Life motto',
                heightToExpand: 100,
                containerHeight: 150,
                text: 'getController.lifeMottoController.text',
              ),
              RoundedExpandedContainer(
                lable: 'Description',
                heightToExpand: 200,
                containerHeight: 150,
                text: getController.describtionController.text,
              ),
              RoundedContainer(
                lable: 'Hobby',
                height: oneLineContainerHeight,
                child: Center(
                  child: Text(
                    'profileController.hobby1Controller.text',
                    style: plainTextStyle,
                  ),
                ),
              ),
              RoundedContainer(
                lable: 'Hobby',
                height: oneLineContainerHeight,
                child: Center(
                  child: Text(
                    ' profileController.hobby2Controller.text',
                    style: plainTextStyle,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: TextContainerLable(
                  text: 'Delete Account',
                  lableStyle: tribalFontLableRed,
                ),
              ),
            ],
          );
        }));
  }
}
