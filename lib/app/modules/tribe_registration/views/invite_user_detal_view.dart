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


class InviteUserDetailView extends StatelessWidget {
  InviteUserDetailView({Key? key}) : super(key: key);

 late var user =  Get.arguments;
  VideoViewerController? videoController = VideoViewerController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: GestureDetector(
            onTap: () {
              videoController?.showAndHideOverlay(false);
            },
            child: ProfileTemplate(
              profileImage: Image.network(user.profilePhoto!.downloadUrl),
              title: const SizedBox.shrink(),
               videoController: videoController!,
              profileVideoSrc: user.introVideo!.downloadUrl,
              fields: [
                verticalSpaceSmall,
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
                      user.hobbies!.hobby,
                      style: plainTextStyle,
                    ),
                  ),
                ),
                RoundedContainer(
                  lable: 'Hobby',
                  height: oneLineContainerHeight,
                  child: Center(
                    child: Text(
                      user.hobbies!.hobby1,
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
