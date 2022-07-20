/* import 'package:chewie/chewie.dart'; */
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/rounded_container.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/rounded_expanded_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../helpers/const.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../../registration/widgets/neumorphic_circle_background.dart';
import '../widgets/video_player.dart';

class ProfileInfoView extends StatelessWidget {
  // final cameraController = Get.put(CameraController());
  // @override
  // final controller = Get.put(ProfileController());

  //  final cameraController = Get.find<CameraController>();
  // final profileController = Get.put(ProfileController());
  final profileController = Get.find<ProfileController>();

  ProfileInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int oneLineContainerHeight = 60;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          print('GestureDetector');
          profileController.videoController.showAndHideOverlay(false);
        },
        child: GetBuilder<ProfileController>(builder: (vontroller) {
          return Column(
            children: [
              verticalSpaceTiny,
              NeumorphicCircleBackground(
                child: MainCirclePhoto.networking(
                    imageSize: 125,
                    screeanheight: 300.h,
                    screeanwidth: 250.w,
                    imagePathN: profileController.profilePhoto),
              ),
              verticalSpaceSmall,
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: AppColors.whiteColor,
                ),
                width: double.infinity,
                height: 400.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                          child: GetBuilder<ProfileController>(
                        init: ProfileController(),
                        builder: (getControllet) => profileController
                                    .videoController !=
                                null
                            ? SizedBox(
                                width: double.infinity,
                                height: 300.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.1.sw),
                                  child: CustomVideoPlayer(
                                    videoController:
                                        profileController.videoController,
                                    videoSrc: profileController.profileVideo,
                                  ),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  spinkit,
                                  const SizedBox(height: 20),
                                  const Text('Loading'),
                                ],
                              ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          children: [
                            RoundedExpandedContainer(
                              heightToExpand: 100,
                              containerHeight: 150,
                              text:
                                  profileController.lifeMottoController.text,
                            ),
                            RoundedExpandedContainer(
                              heightToExpand: 200,
                              containerHeight: 150,
                              text: profileController
                                  .describtionController.text,
                            ),
                            RoundedContainer(
                              height: oneLineContainerHeight,
                              child: Center(
                                child: Text(
                                  profileController.hobby1Controller.text,
                                  style: plainTextStyle,
                                ),
                              ),
                            ),
                            RoundedContainer(
                              height: oneLineContainerHeight,
                              child: Center(
                                child: Text(
                                  profileController.hobby2Controller.text,
                                  style: plainTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
