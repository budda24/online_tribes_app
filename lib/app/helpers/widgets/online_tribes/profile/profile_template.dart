import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_viewer/domain/bloc/controller.dart';

import '../../../../modules/profile/widgets/bacground_rounded_container.dart';
import '../../../../modules/profile/widgets/video_player.dart';



import '../../../theme/app_colors.dart';
import '../../../theme/ui_helpers.dart';
import '../general/main_button.dart';
import '../general/main_constants.dart';

class ProfileTemplate extends StatelessWidget {
  ProfileTemplate({
    Key? key,
    this.videoController,
    required this.fields,
    required this.title,
    required this.videoSrc,
    required this.profileImage,
    this.button,
  }) : super(key: key);

  final VideoViewerController? videoController;

  final Widget title;
  final String? videoSrc;
  final List<Widget> fields;
  Image profileImage;
  SlimRoundedButton? button;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 0.25.sh,
              child: Padding(
                padding: EdgeInsets.only(top: 5.h, right: 25.w, left: 25.w),
                child: Center(
                  child: title,
                ),
              ),
            ),
            BacgroundRoundedContainer(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpaceExtraLarge,
                      videoSrc != null
                          ? videoController != null
                              ? CustomVideoPlayer.network(
                                  videoSrc: videoSrc,
                                  videoController: videoController!)
                              : const SizedBox.shrink()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                spinkit,
                                const SizedBox(height: 20),
                                const Text('Loading'),
                              ],
                            ),
                      ...fields,
                      verticalSpaceLarge,
                      button ?? const SizedBox.shrink(),
                      verticalSpaceLarge
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 125,
          top: 120,
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
      ],
    );
  }
}
