import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/main_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../helpers/assets/networkIng_images.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

class RegistrationUploadVideoView extends GetView {
  @override
  Widget build(BuildContext context) {
    /*  ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(411, 809),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait); */
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
                        'https://dsm01pap004files.storage.live.com/y4m8Gv2oQvIHsLDNWMzjGmwED5go2S5vTwmIUrRXMQlfNdXE8Ci9tFYqmOY9YGvH71OlN48CCzO_loiE1o_HOrvS0EqD9hV5DcJQ8Cp8F3C2mNnDBHksPpetGNWPQ6alGIrP9flcw5nXBgvplbF3vJ3sKNlB8BPnxWNrTNwc23WO2T8qP91vf8oWiP2Z8LpOpYs?width=240&height=135&cropmode=none',
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
                    color: AppColors.primaryColorWithOpacity40,
                  ),
                  width: double.infinity,
                  height: 558.h,
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Text(
                        'Upload your video',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      MainCirclePhoto.networking(
                          /* imagePathL: '', */
                          imagePathN:
                              'https://dsm01pap004files.storage.live.com/y4mN1n5-qwfsbFUlvA6ydVtMe85BUIbCmFU_2hx56ov0z12HXdnnLs06nSBQnzH2jbGeVynA4nURa2Gc7FmVQIKMANb_OdmEZuDZ7syf6VGmgs5a_Dl8Ags9VZ3xoTTnIfOwx-rMlrshAGTajYSXR3z4OiYe9MQ4LeJyL9IftcnJHpdJXj2RzQeUc9prj7TeeTH?width=142&height=143&cropmode=none',
                          screeanheight: 673.h,
                          screeanwidth: 392.w),
                     SizedBox(height: 25.h,),
                      MainCirclePhoto.networking(
                          /* imagePathL: '', */
                          imagePathN:
                              'https://dsm01pap004files.storage.live.com/y4mLJ2fKNEHobwfVz23jz1PNLX-ohpsdYyWmwOjMCFirQHqUe7NPC67yj0W8rspoGlOJZsUHjXpbLkhigoW4biCzvT_GHt-Jhn7f9Ex9RDrzqEipyKlef0XIHxrvEV4uDPKWM9SXoXSu3mdVikSS_q9Jm7odFlMYoihxtz7yeXjoH7Fls2ms1b5uCynA7OOpH0V?width=142&height=143&cropmode=none',
                          screeanheight: 673.h,
                          screeanwidth: 392.w),
                     SizedBox(height: 65.h,),
                      SlimRoundedButton(
                          backgroundColour: AppColors.primaryColor,
                          title: 'Continue',
                          textColor: AppColors.whiteColor,
                          onPress: () {})
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
