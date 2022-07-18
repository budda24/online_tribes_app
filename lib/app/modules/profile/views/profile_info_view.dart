import 'package:chewie/chewie.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/rounded_container.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/rounded_expanded_container.dart';
import 'package:flutter_application_1/app/modules/registration/widgets/neumorphic_circle_background.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../widgets/custom_navigation_bar.dart';

class ProfileView extends GetView {
  final cameraController = Get.find<CameraController>();
  final profileController = Get.put(ProfileController());

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int oneLineContainerHeight = 60;

    return Scaffold(
      bottomNavigationBar:
          CustomNavigationBar(actualIndex: profileController.actualIndex),
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              verticalSpaceTiny,
              NeumorphicCircleBackground(
                child: MainCirclePhoto.file(
                
                    screeanheight: 300.h,
                    screeanwidth: 250.w,
                    file: cameraController.pickedPhoto!),
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
                height: 426.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: profileController.chewieController != null &&
                                profileController.chewieController!
                                    .videoPlayerController.value.isInitialized
                            ? SizedBox(
                                width: double.infinity,
                                height: 300.h,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Chewie(
                                    controller:
                                        profileController.chewieController!,
                                  ),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 20),
                                  Text('Loading'),
                                ],
                              ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          children: [
                            RoundedExpandedContainer(
                              containerHeight: 200,
                              text: lorem(paragraphs: 2, words: 26),
                            ),
                            RoundedContainer(
                              height: oneLineContainerHeight,
                              child: Center(
                                child: Text(
                                  'Tribal name',
                                  style: plainTextStyle,
                                ),
                              ),
                            ),
                            RoundedContainer(
                              height: oneLineContainerHeight,
                              child: Center(
                                child: Text(
                                  'Hobby 1',
                                  style: plainTextStyle,
                                ),
                              ),
                            ),
                            RoundedContainer(
                              height: oneLineContainerHeight,
                              child: Center(
                                child: Text(
                                  'Hobby 1',
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
          ),
        ),
      ),
    );
  }
}