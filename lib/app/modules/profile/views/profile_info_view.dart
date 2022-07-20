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

import '../../../controllers/camea_controller.dart';
import '../../../helpers/const.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../../registration/widgets/neumorphic_circle_background.dart';
import '../widgets/custom_navigation_bar.dart';
import '../widgets/video_player.dart';

class ProfileInfoView extends GetView<ProfileController> {
  final cameraController = Get.put(CameraController());
  @override
  final controller = Get.put(ProfileController());

  ProfileInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int oneLineContainerHeight = 60;

    return GestureDetector(
      onTap: () {
        print('GestureDetector');
        controller.videoController.showAndHideOverlay(false);
      },
      child: Scaffold(
        bottomNavigationBar:
            CustomNavigationBar(actualIndex: controller.actualIndex),
        backgroundColor: kMainColor,
        body: SafeArea(
          child: GetBuilder<ProfileController>(builder: (vontroller) {
            return Column(
              children: [
                verticalSpaceTiny,
                MainCirclePhoto.networking(
                    imageSize: 100,
                    screeanheight: 300.h,
                    screeanwidth: 250.w,
                    imagePathN: controller.profilePhoto),
                verticalSpaceSmall,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: AppColors.whiteColor,
                  ),
                  width: double.infinity,
                  height: 426.h,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                            child: GetBuilder<ProfileController>(
                          init: ProfileController(),
                          builder: (getControllet) =>
                              controller.videoController != null
                                  ? SizedBox(
                                      width: double.infinity,
                                      height: 300.h,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0.1.sw),
                                        child: CustomVideoPlayer(
                                          videoController:
                                              controller.videoController,
                                          videoSrc: controller.profileVideo,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                text: controller.lifeMottoController.text,
                              ),
                              RoundedExpandedContainer(
                                heightToExpand: 200,
                                containerHeight: 150,
                                text: controller.describtionController.text,
                              ),
                              RoundedContainer(
                                height: oneLineContainerHeight,
                                child: Center(
                                  child: Text(
                                    controller.hobby1Controller.text,
                                    style: plainTextStyle,
                                  ),
                                ),
                              ),
                              RoundedContainer(
                                height: oneLineContainerHeight,
                                child: Center(
                                  child: Text(
                                    controller.hobby2Controller.text,
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
      ),
    );
  }
}
