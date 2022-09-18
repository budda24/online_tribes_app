import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/fb_services/models/user_model.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../../user_profile/widgets/rounded_expanded_container.dart';
import '../../user_profile/widgets/rounded_container.dart';
import '../../user_profile/widgets/video_player.dart';

class InviteUserDetailView extends StatelessWidget {
  InviteUserDetailView({Key? key}) : super(key: key);

  late var user = Get.arguments as UserDB;
  VideoViewerController videoController = VideoViewerController();

  @override
  Widget build(BuildContext context) {
    print(user.toJson());
    print(videoController);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: GestureDetector(
            onTap: () {
              videoController.showAndHideOverlay(false);
            },
            child: ProfileTemplate(
              profileImage: Image.network(user.profilePhotoRef!.downloadUrl),
              title: const SizedBox.shrink(),
              //TODOthrows error brcause there is no controller given to the getBuilder
              /* videoPlayer: GetBuilder(
                builder: (builderController) =>
                    user.introVideoRef!.downloadUrl != ''
                        ? videoController != null
                            ? CustomVideoPlayer.network(
                                videoSrc: user.introVideoRef!.downloadUrl,
                                videoController: videoController)
                            : const SizedBox.shrink()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              spinkit,
                              const SizedBox(height: 20),
                              const Text('Loading'),
                            ],
                          ),
              ), */
              /* ,
               videoController: videoController!,
              profileVideoSrc: user.introVideo!.downloadUrl, */
              fields: [
                verticalSpace20,
                RoundedExpandedContainer(
                  lable: 'Life motto',
                  heightToExpand: 100,
                  containerHeight: 150,
                  text: user.lifeMotto!,
                ),
                RoundedExpandedContainer(
                  lable: 'Description',
                  heightToExpand: 200,
                  containerHeight: 150,
                  text: user.description!,
                ),
                RoundedContainer(
                  lable: 'Hobby',
                  height: oneLineContainerHeight,
                  child: Center(
                    child: Text(
                      user.hobby!,
                      style: plainTextStyle,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
