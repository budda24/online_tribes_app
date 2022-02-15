import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../helpers/assets/networkIng_images.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import 'registration_desrription_view.dart';
import 'registration_upload_video_view.dart';

class RegistrationAditionalView extends GetView {
  @override
  Widget build(BuildContext context) {
    int _height = 5;

    return Scaffold(
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MainCirclePhoto.networking(
                    /* imagePathL: '', */
                    imagePathN:
                        'https://dsm01pap004files.storage.live.com/y4mSRmRba6CZt7pLPVH8rEZi5Prrp8uepLnPUxlFwcFmh9BvkfO214be-EdO0lNJXpkv0wprRH4wKVRsOEt3K9nBpLQoHtVi0H9UavgBqZ1JTlWgTqZ1Y7kZE1SBtbY3ZUTHVTpbmEFacDRkOI675QQFEJSMZBUPyXbW2HNfG0uUOp2vzTdTOKt12gp9EUf8V2P?width=1920&height=1080&cropmode=none',
                    screeanheight: 673.h,
                    screeanwidth: 392.w),
                Text(
                  'Cornelius',
                  style: kName,
                ),
                CustomTextField(
                  hintText: 'The Life Motto',
                  maxline: 6,
                  minLine: 1,
                  height: 200.h,
                  width: 500.w,
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: 380,
                      height: 60,
                    ),
                    Positioned(
                      left: 32.w,
                      child: SlimRoundedButton(
                        onPress: () =>
                            Get.to(() => RegistrationUploadVideoView()),
                        backgroundColour: AppColors.textFieldFill,
                        title: 'Hobbies',
                        textColor: kTextColorDarkGrey,
                        /* screenWidth: screeanwidth,
                              screenHeight: screeanheight */
                      ),
                    ),
                    Positioned(
                      left: 330,

                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: AppColors.whiteColor,
                        child: Icon(Icons.add),
                      ),
                    )
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      trackHeight: 20.h,
                      inactiveTrackColor: AppColors.whiteColor,
                      activeTrackColor: AppColors.whiteColor,
                      thumbColor: AppColors.blueColor,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 30.0),
                      overlappingShapeStrokeColor: AppColors.blueColor,
                      overlayColor: kColorWhite,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 33.0)),
                  child: Stack(
                    children: [
                      Slider(
                        label: 'time to invest',
                        divisions: 10,
                        value: _height.toDouble(),
                        min: 1,
                        max: 30,
                        onChanged: (double newValue) {
                          _height = newValue.round();
                        },
                      ),
                      Positioned(
                          left: 150.w,
                          top: 25.h,
                          child: Text('Time to invest')),
                    ],
                  ),
                ),
                SizedBox(
                  height: 98.h,
                ),
                SlimRoundedButton(
                  onPress: () => Get.to(() => RegistrationUploadVideoView()),
                  backgroundColour: kColorWhite,
                  title: 'Continue',
                  textColor: kTextColorDarkGrey,
                  /* screenWidth: screeanwidth,
                        screenHeight: screeanheight */
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
