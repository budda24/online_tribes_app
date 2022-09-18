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
import '../controllers/user_profile_controller.dart';
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
          profileImage:
              Image.network(getController.userDB!.profilePhotoRef!.downloadUrl),
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
                          profileController.prepareEditingMode();
                          cameraController.clearPickedPhotoAndVideo();
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
                      GetBuilder<CameraController>(
                        builder: (_) {
                          return Text(
                            cameraController.pickedPhoto != null
                                ? 'Changed profile picture'
                                : 'Change profile picture',
                            style: cameraController.pickedPhoto != null
                                ? greenActionTitle
                                : greenTitle,
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await cameraController.getImageCamera();
                              if (cameraController.pickedPhoto != null) {
                                /* profileController
                                              .switchIsVideoCosen(); */
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 25),
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
                                  type: PickedType.photo);
                              if (cameraController.pickedPhoto != null) {
                                /* profileController
                                              .switchIsVideoCosen(); */
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 25),
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                'assets/images/authorization_screen/upload_video.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace20,
                  CustomTextField(
                    textInputAction: TextInputAction.next,
                    tribesLable: 'Life motto',
                    controller: profileController.textLifeMottoController,
                    /*  validate: (value) =>
              controller.validateUser(value: value, lenght: 200), */
                    hintText: 'The Life Motto',
                    maxline: 6,
                    minLine: 1,
                    height: 130.h,
                    width: 500.w,
                  ),
                  verticalSpace20,
                  CustomTextField(
                    tribesLable: 'Description',
                    controller: profileController.textDescribtionController,
                    hintText: 'Describe yourself',
                    maxline: 12,
                    minLine: 8,
                    height: 280.h,
                    width: 400.w,
                  ),
                  verticalSpace20,
                  CustomTextField(
                    tribesLable: 'Hobby',
                    controller: profileController.textHobbyController,
                    textInputAction: TextInputAction.next,
                    hintText: 'Hobby',
                    maxline: 1,
                    minLine: 1,
                    height: 50.h,
                    width: 500.w,
                  ),
                  verticalSpace20,
                  Column(
                    children: [
                      verticalSpace20,
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
                      verticalSpace10,
                      profileController.progress == 0.0
                          ? Column(
                              children: [
                                GetBuilder<CameraController>(
                                  builder: (_) {
                                    return Text(
                                      cameraController.pickedVideo != null
                                          ? ' Changed introduction video'
                                          : 'Change introduction video',
                                      style:
                                          cameraController.pickedVideo != null
                                              ? greenActionTitle
                                              : greenTitle,
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await cameraController.getVideoCamera();
                                        if (cameraController.pickedVideo !=
                                            null) {
                                          /* profileController
                                            .switchIsVideoCosen(); */
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 25),
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
                                        margin: const EdgeInsets.only(top: 25),
                                        height: 100,
                                        width: 100,
                                        child: Image.asset(
                                          'assets/images/authorization_screen/upload_video.png',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      verticalSpace25,
                      GetBuilder<ProfileController>(
                        builder: (_) {
                          return Text(
                            profileController.availableTime != null
                                ? ' Changed availability time'
                                : 'Change available time for meeting',
                            style: profileController.availableTime != null
                                ? greenActionTitle
                                : greenTitle,
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                      AvailableTimeButton(onPressed: () async {
                        profileController.availableTime =
                            await TimeCovertingServices()
                                .getCustomTimeRangePicker(context);
                        profileController.update();
                      })
                    ],
                  ),
                ]
              : [
                  verticalSpace20,
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
                    text: getController.textLifeMottoController.text,
                  ),
                  RoundedExpandedContainer(
                    lable: 'Description',
                    heightToExpand: 200,
                    containerHeight: 150,
                    text: getController.textDescribtionController.text,
                  ),
                  RoundedContainer(
                    lable: 'Hobby',
                    height: oneLineContainerHeight,
                    child: Center(
                      child: Text(
                        profileController.textHobbyController.text,
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
                      builderController.userDB!.introVideoRef!.downloadUrl != ''
                          ? builderController.videoController != null
                              ? CustomVideoPlayer.network(
                                  videoSrc: builderController
                                      .userDB!.introVideoRef!.downloadUrl,
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
