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
    required this.profileImage,
    this.rigtTopIconColumn,
    this.leftTopIconColumn,
    this.videoPlayer,
    this.button,
    this.isEditingMode,
  }) : super(key: key);

  final Widget? title;
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
          isEditingMode != null && isEditingMode == true
              ? const SizedBox.shrink()
              : Positioned.fill(
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
