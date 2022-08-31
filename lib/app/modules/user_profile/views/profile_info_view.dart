//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

// Project imports:
import '../../../../infrastructure/native_functions/time_converting_services.dart';
import '../../../controllers/camera_controller.dart';
import '../../../helpers/theme/alert_styles.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../../../helpers/widgets/online_tribes/registration/custom_text_field.dart';
import '../../../helpers/widgets/online_tribes/registration/time_range_button.dart';
import '../controllers/profile_controller.dart';
import '../widgets/rounded_container.dart';
import '../widgets/rounded_expanded_container.dart';
import '../widgets/video_player.dart';

class ProfileInfoView extends StatelessWidget {
  ProfileInfoView({Key? key}) : super(key: key);

  final profileController = Get.find<ProfileController>();

  final cameraController = Get.find<CameraController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        profileController.videoController?.showAndHideOverlay(false);
      },
      child: GetBuilder<ProfileController>(builder: (getController) {
        return ProfileTemplate(
          isEditingMode: profileController.isEditingMode,
          profileImage: Image.network(getController.profilePhotoUrl),
          leftTopIconColumn: profileController.isEditingMode
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      InkWell(
                        onTap: () async {
                          await profileController.updateUser();
                        },
                        child: Icon(
                          Icons.save,
                          size: 35,
                          color: AppColors.actionColor,
                        ),
                      ),
                      Text(
                        'save',
                        style: iconTextStyle,
                      ),
                    ])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      InkWell(
                        onTap: () {
                          /* profileController.logout(); */
                          print(profileController
                              .userDB!.availableTime!.timeZone);
                        },
                        child: Icon(
                          Icons.logout,
                          size: 35,
                          color: AppColors.actionColor,
                        ),
                      ),
                      Text(
                        'log out',
                        style: iconTextStyle,
                      ),
                    ]),
          rigtTopIconColumn: profileController.isEditingMode
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      InkWell(
                        onTap: () {
                          profileController.isEditingMode = false;
                          profileController.cancelUserChanges();
                        },
                        child: Icon(
                          Icons.cancel,
                          size: 35,
                          color: AppColors.actionColor,
                        ),
                      ),
                      Text(
                        'cancel',
                        style: iconTextStyle,
                      ),
                    ])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      InkWell(
                        onTap: () {
                          profileController.saveUserBeforeChanges();
                          profileController.isEditingMode = true;
                          profileController.rebuild();
                        },
                        child: Icon(
                          Icons.edit,
                          size: 35,
                          color: AppColors.actionColor,
                        ),
                      ),
                      Text(
                        'edit',
                        style: iconTextStyle,
                      ),
                    ]),
          title: const SizedBox.shrink(),
          fields: profileController.isEditingMode
              ? [
                  Column(
                    children: [
                      cameraController.pickedVideo != null &&
                              profileController.progress == 0.0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_rounded,
                                  color: AppColors.actionColor,
                                  size: 30.sp,
                                ),
                                Text(
                                  'Video is chosen',
                                  style: greenActionTitle,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      verticalSpaceSmall,
                      profileController.progress == 0.0
                          ? const SizedBox.shrink()
                          : Container(
                              height: 300,
                              margin: const EdgeInsets.only(top: 70),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularPercentIndicator(
                                    radius: 100.w,
                                    lineWidth: 20.w,
                                    percent: profileController.progress / 100,
                                    backgroundColor: AppColors.primaryColor,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    linearGradient: LinearGradient(colors: [
                                      AppColors.primaryColor,
                                      AppColors.actionColor,
                                    ]),
                                    rotateLinearGradient: true,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    animationDuration: 2000,
                                    curve: Curves.bounceIn,
                                    widgetIndicator: Image.asset(
                                      'assets/images/authorization_screen/logo/50x50.png',
                                    ),
                                    center: Text(
                                      '${profileController.progress} %',
                                      style: headingBoldStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      verticalSpaceTiny,
                      profileController.progress == 0.0
                          ? Container(
                              child: Column(
                                children: [
                                  Text(
                                    'Change introduction video',
                                    style: greenTitle,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await cameraController
                                              .getVideoCamera();
                                          if (cameraController.pickedVideo !=
                                              null) {
                                            /* profileController
                                                .switchIsVideoCosen(); */
                                          }
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 25),
                                          height: 100,
                                          width: 100,
                                          child: Image.asset(
                                            'assets/images/authorization_screen/add_photo.png',
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await cameraController.getFileGallery(
                                              type: PickedType.video);
                                          if (cameraController.pickedVideo !=
                                              null) {
                                            /* profileController
                                                .switchIsVideoCosen(); */
                                          }
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 25),
                                          height: 100,
                                          width: 100,
                                          child: Image.asset(
                                            'assets/images/authorization_screen/upload_video.png',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalSpaceMedium,
                                  Text(
                                    'Change available time for meeting',
                                    style: greenTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                  AvailableTimeButton(onPressed: () async {
                                    profileController.availableTime =
                                        await TimeCovertingServices()
                                            .getCustomTimeRangePicker(context);
                                  })
                                ],
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                  verticalSpaceSmall,
                  CustomTextField(
                    textInputAction: TextInputAction.next,
                    tribesLable: 'Life motto',
                    controller: profileController.lifeMottoController,
                    /*  validate: (value) =>
              controller.validateUser(value: value, lenght: 200), */
                    hintText: 'The Life Motto',
                    maxline: 6,
                    minLine: 1,
                    height: 130.h,
                    width: 500.w,
                  ),
                  verticalSpaceSmall,
                  CustomTextField(
                    tribesLable: 'Description',
                    controller: profileController.describtionController,
                    hintText: 'Describe yourself',
                    maxline: 12,
                    minLine: 8,
                    height: 280.h,
                    width: 400.w,
                  ),
                  verticalSpaceSmall,
                  CustomTextField(
                    tribesLable: 'Hobby',
                    controller: profileController.hobby1Controller,
                    /*  validate: (value) =>
              controller.validateUser(value: value, lenght: 50), */
                    textInputAction: TextInputAction.next,
                    hintText: 'Hobby 1',
                    maxline: 1,
                    minLine: 1,
                    height: 50.h,
                    width: 500.w,
                  ),
                  verticalSpaceSmall,
                  CustomTextField(
                    tribesLable: 'Hobby',
                    controller: profileController.hobby2Controller,
                    /*  validate: (value) =>
              controller.validateUser(value: value, lenght: 50), */
                    textInputAction: TextInputAction.next,
                    hintText: 'Hobby 2',
                    maxline: 1,
                    minLine: 1,
                    height: 50.h,
                    width: 500.w,
                  ),
                ]
              : [
                  verticalSpaceSmall,
                  Text(
                    'Availability',
                    style: tribalFontLable,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        profileController
                            .userDB!.availableTime!.start.hours.inHours
                            .toString(),
                        style: tribalFontLableRed,
                      ),
                      Text(
                        "-",
                        style: tribalFontLableRed,
                      ),
                      Text(
                        profileController
                            .userDB!.availableTime!.end.hours.inHours
                            .toString(),
                        style: tribalFontLableRed,
                      ),
                    ],
                  ),
                  RoundedExpandedContainer(
                    lable: 'Life motto',
                    heightToExpand: 100,
                    containerHeight: 150,
                    text: getController.lifeMottoController.text,
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
                        profileController.hobby1Controller.text,
                        style: plainTextStyle,
                      ),
                    ),
                  ),
                  RoundedContainer(
                    lable: 'Hobby',
                    height: oneLineContainerHeight,
                    child: Center(
                      child: Text(
                        profileController.hobby2Controller.text,
                        style: plainTextStyle,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Alerts.confirmation(
                                onConfirm: profileController.deleteUser,
                                title: "Are you Sure you want to delete",
                                content:
                                    "All you data will be deleted irreversibly ")
                            .showConfirmDialog();
                      },
                      child: TextContainerLable(
                        text: 'Delete Account',
                        lableStyle: tribalFontLableRed,
                      )),
                ],
          videoPlayer: !profileController.isEditingMode
              ? GetBuilder<ProfileController>(
                  builder: (builderController) =>
                      builderController.profileVideoUrl != ''
                          ? builderController.videoController != null
                              ? CustomVideoPlayer.network(
                                  videoSrc: getController.profileVideoUrl,
                                  videoController:
                                      builderController.videoController!)
                              : const SizedBox.shrink()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                spinkit,
                                const SizedBox(height: 20),
                                const Text('Loading'),
                              ],
                            ),
                )
              : const SizedBox.shrink(),
        );
      }),
    );
  }
}