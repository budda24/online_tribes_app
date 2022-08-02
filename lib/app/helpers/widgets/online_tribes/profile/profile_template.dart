import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_viewer/domain/bloc/controller.dart';

import '../../../../modules/profile/widgets/bacground_rounded_container.dart';
import '../../../../modules/profile/widgets/video_player.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';
import '../../../theme/ui_helpers.dart';
import '../general/main_constants.dart';

class ProfileTemplate extends StatelessWidget {
  ProfileTemplate({
    Key? key,
    this.videoController,
    required this.fields,
    required this.title,
    required this.profileVideoSrc,
    required this.profileImage,
    this.button,
  }) : super(key: key);

  final VideoViewerController? videoController;

  final Widget title;
  final String? profileVideoSrc;
  final List<Widget> fields;
  Image profileImage;
  Widget? button;

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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpaceExtraLarge,
                    profileVideoSrc != null
                        ? videoController != null
                            ? CustomVideoPlayer.network(
                                videoSrc: profileVideoSrc!,
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
                    button != null
                        ? verticalSpaceLarge
                        : const SizedBox.shrink(),
                    button ?? const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
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
            top: 0,
            right: 30,
            child: Align(
                alignment: Alignment.topRight,
                child: button ?? const SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}
