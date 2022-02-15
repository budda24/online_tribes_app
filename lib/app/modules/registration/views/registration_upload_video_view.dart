import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../helpers/assets/networkIng_images.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

class RegistrationUploadVideoView extends GetView {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(411, 809),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [

                MainCirclePhoto.networking(
                  /* imagePathL: '', */
                  imagePathN:
                      'https://dsm01pap004files.storage.live.com/y4mSRmRba6CZt7pLPVH8rEZi5Prrp8uepLnPUxlFwcFmh9BvkfO214be-EdO0lNJXpkv0wprRH4wKVRsOEt3K9nBpLQoHtVi0H9UavgBqZ1JTlWgTqZ1Y7kZE1SBtbY3ZUTHVTpbmEFacDRkOI675QQFEJSMZBUPyXbW2HNfG0uUOp2vzTdTOKt12gp9EUf8V2P?width=1920&height=1080&cropmode=none',
                  screeanheight: 673.h.h,
                  screeanwidth: 392.w),
              Text(
                'Cornelius',
                style: kName,
              ),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: AppColors.whiteColor,
                  ),
                  width: double.infinity,
                  height: 558.h,
                  child: Column(
                    children: [Text('Upload your video'),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
