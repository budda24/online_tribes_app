import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/user_profile/widgets/rounded_container.dart';
import 'package:flutter_application_1/infrastructure/native_functions/time_converting_services.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/fb_services/models/tribe_model.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../../user_profile/widgets/rounded_expanded_container.dart';
import '../../user_profile/widgets/video_player.dart';
import '../controllers/tribe_profile_controller.dart';

class TribeProfileView extends GetView<TribeProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: GetBuilder<TribeProfileController>(builder: (getController) {
          TribeDb? tribeDb = controller.tribeDb;

          return ProfileTemplate(
            
            videoPlayer: GetBuilder<TribeProfileController>(
                /* didUpdateWidget: (oldWidget, state) => print('didUpdateWidget'),
                initState: (contr) => print('initState'),
                didChangeDependencies: (cont) => print('didChangeDependencies'),
                dispose: (con) => print('dispose'), */
                builder: (builderController) {
              return tribeDb!.tribalIntroVideo!.downloadUrl != ''
                  ? builderController.videoController != null
                      ? CustomVideoPlayer.network(
                          type: VideoAsset.network,
                          videoSrc: tribeDb.tribalIntroVideo!.downloadUrl,
                          videoController: builderController.videoController)
                      : const SizedBox.shrink()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        spinkit,
                        const SizedBox(height: 20),
                        const Text('Loading'),
                      ],
                    );
            }),
            profileImage: tribeDb!.customTribalSign == null
                ? Image.asset(tribeDb.localTribalSign!)
                : Image.network(tribeDb.customTribalSign!.downloadUrl),
            /* rigtTopPositionad: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Log Out',
                    style: greenTitle,
                  ),
                  InkWell(
                    onTap: () {
                      //TODO LOGOUT tribe??
                      /* profileController.logout(); */
                    },
                    child: Icon(
                      Icons.logout,
                      size: 50,
                      color: AppColors.actionColor,
                    ),
                  ),
                ]), */
            title: Text(
              tribeDb.tribalName!,
              style: tribalFontLable,
            ),
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
                    TimeCovertingServices.CountOffsetHour(
                            hour: tribeDb.availableTime!.startZero,
                            offset: DateTime.now().timeZoneOffset.inHours)
                        .toString(),
                    style: tribalFontLableRed,
                  ),
                  Text(
                    "-",
                    style: tribalFontLableRed,
                  ),
                  Text(
                    TimeCovertingServices.CountOffsetHour(
                            hour: tribeDb.availableTime!.endZero,
                            offset: DateTime.now().timeZoneOffset.inHours)
                        .toString(),
                    style: tribalFontLableRed,
                  ),
                ],
              ),
              RoundedExpandedContainer(
                lable: 'Triberers Type',
                heightToExpand: 150,
                containerHeight: 100,
                text: tribeDb.triberersType!,
              ),
              RoundedContainer(
                height: oneLineContainerHeight,
                lable: 'Tribe Type',
                child: Text(
                  tribeDb.type!,
                  textAlign: TextAlign.center,
                  style: plainTextStyle,
                ),
              ),
              RoundedExpandedContainer(
                lable: 'Description',
                heightToExpand: 200,
                containerHeight: 150,
                text: tribeDb.description!,
              ),

              /* RoundedContainer(
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
              ),*/
            ],
          );
        }));
  }
}
