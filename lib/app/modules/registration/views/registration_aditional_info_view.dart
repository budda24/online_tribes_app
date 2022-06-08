import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../helpers/assets/networkIng_images.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import 'registration_desrription_view.dart';
import 'registration_upload_video_view.dart';

class RegistrationAditionalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _height = 5;
    final _formKey = GlobalKey<FormState>();
    final controller = Get.find<RegistrationController>();
    final globalController = Get.find<GlobalController>();

     ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    return GestureDetector(
      onTap:globalController.unFocuseNode,
      child: Scaffold(
        backgroundColor: kMainColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MainCirclePhoto.networking(
                        /* imagePathL: '', */
                        imagePathN:
                            'https://dsm01pap004files.storage.live.com/y4m8Gv2oQvIHsLDNWMzjGmwED5go2S5vTwmIUrRXMQlfNdXE8Ci9tFYqmOY9YGvH71OlN48CCzO_loiE1o_HOrvS0EqD9hV5DcJQ8Cp8F3C2mNnDBHksPpetGNWPQ6alGIrP9flcw5nXBgvplbF3vJ3sKNlB8BPnxWNrTNwc23WO2T8qP91vf8oWiP2Z8LpOpYs?width=240&height=135&cropmode=none',
                        screeanheight: 673.h,
                        screeanwidth: 392.w),
                    Text(
                      'Cornelius',
                      style: kName,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      onSave: () {},
                      hintText: 'The Life Motto',
                      maxline: 6,
                      minLine: 1,
                      height: 200.h,
                      width: 500.w,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Stack(
                      children: [
                        /* CustomTextField(
                          height: 60,
                          width: 500,
                          hintText: 'Hobbies',
                          maxline: 1,
                          minLine: 1,
                          onSave: () {},
                        ), */

                        Container(
                          width: 500.w,
                          height: 160.h,
                          padding: EdgeInsets.all(5.h),
                          child: SingleChildScrollView(
                            child: Obx(() {
                              final tmpList =
                                  controller.hobbiesFields.reversed.toList();
                              print(tmpList);
                              return Column(
                                children: [
                                  ...tmpList,
                                ],
                              );
                            }),
                          ),
                        ),
                        Positioned(
                          left: 350.w,
                          child: GestureDetector(
                            onTap: () {
                              print('add hobbies');
                              controller.addHobbyField();
                            },
                            child: CircleAvatar(
                              radius: 15.r,
                              backgroundColor: AppColors.whiteColor,
                              child: Icon(Icons.add),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          trackHeight: 20.h,
                          inactiveTrackColor: AppColors.whiteColor,
                          activeTrackColor: AppColors.whiteColor,
                          thumbColor: AppColors.blueColor,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 25.0),
                          showValueIndicator: ShowValueIndicator.onlyForDiscrete,
                          overlappingShapeStrokeColor: AppColors.blueColor,
                          overlayColor: kColorWhite,
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 33.0,
                          )),
                      child: Stack(
                        children: [
                          Obx(() => Slider(
                                value: controller.range.value,
                                min: 0.0,
                                max: 5.0,
                                divisions: 5,
                                label: controller.range.round().toString(),
                                onChanged: (double value) {
                                  controller.setRange(value);
                                },
                              )),
                          Positioned(
                              left: 150.w,
                              top: 25.h,
                              child: Text('Time to invest')),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SlimRoundedButton(
                      onPress: () {
                        _formKey.currentState!.validate();
                        Get.to(() => RegistrationUploadVideoView());
                      },
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
        ),
      ),
    );
  }
}
