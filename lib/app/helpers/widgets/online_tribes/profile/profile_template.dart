import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/user_profile/controllers/profile_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_viewer/domain/bloc/controller.dart';

import '../../../../modules/user_profile/widgets/bacground_rounded_container.dart';
import '../../../../modules/user_profile/widgets/video_player.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/ui_helpers.dart';
import '../../../theme/main_constants.dart';

class ProfileTemplate extends StatelessWidget {
  ProfileTemplate({
    Key? key,
    required this.fields,
    required this.title,
    /* required this.profileVideoSrc, */
    required this.profileImage,

    this.rigtTopIconColumn,
    this.leftTopIconColumn,
    this.videoPlayer,
    /* this.videoController, */

    this.button,
    this.isEditingMode,
  }) : super(key: key);

  /* final VideoViewerController? videoController; */

  final Widget title;
  /* final String? profileVideoSrc; */
  final List<Widget> fields;
  Image profileImage;
  Widget? button;
  Column? rigtTopIconColumn;
  Column? leftTopIconColumn;
  bool? isEditingMode;

  Widget? videoPlayer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 1.sh,
          ),
          BacgroundRoundedContainer.profile(
            height: 530,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10),
                child: Column(
                  children: [
                    verticalSpaceLarge,
                    videoPlayer ?? const SizedBox.shrink(),
                    ...fields,
                    button != null
                        ? verticalSpaceLarge
                        : const SizedBox.shrink(),
                    button ?? const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
          isEditingMode != null && isEditingMode ==  true
              ? const SizedBox.shrink()
              : Positioned(
                  left: 125,
                  top: 70,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: AppColors.primaryColor,
                    child: CircleAvatar(
                      backgroundImage: profileImage.image,
                      radius: 65,
                      backgroundColor: AppColors.greyColor,
                    ),
                  ),
                ),
          Positioned.fill(
            top: 70,
            right: 15,
            child: Align(
              alignment: Alignment.topRight,
              child: rigtTopIconColumn,
            ),
          ),
          Positioned.fill(
            top: 70,
            left: 15,
            child: Align(
              alignment: Alignment.topLeft,
              child: leftTopIconColumn,
            ),
          ),
        ],
      ),
    );
  }
}
