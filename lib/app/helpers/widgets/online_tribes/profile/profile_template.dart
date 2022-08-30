import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../modules/user_profile/widgets/bacground_rounded_container.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/ui_helpers.dart';

class ProfileTemplate extends StatelessWidget {
  ProfileTemplate({
    Key? key,
    required this.fields,
    this.title,
    /* required this.profileVideoSrc, */
    required this.profileImage,
    this.videoPlayer,
    /* this.videoController, */
    this.rigtTopPositionad,
    this.button,
  }) : super(key: key);

  /* final VideoViewerController? videoController; */

  final Widget? title;
  /* final String? profileVideoSrc; */
  final List<Widget> fields;
  Image profileImage;
  Widget? button;
  Column? rigtTopPositionad;
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
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  verticalSpaceMedium,
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: AppColors.primaryColor,
                    child: CircleAvatar(
                      backgroundImage: profileImage.image,
                      radius: 65,
                      backgroundColor: AppColors.greyColor,
                    ),
                  ),
                  title == null ? const SizedBox.shrink() : title!,
                ],
              ),
            ),
          ),
          /* Positioned(
            left: 125,
            top: 215,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ,
              ],
            ),
          ), */
          Positioned.fill(
            top: 50,
            right: 10,
            child: Align(
              alignment: Alignment.topRight,
              child: rigtTopPositionad,
            ),
          ),
        ],
      ),
    );
  }
}
