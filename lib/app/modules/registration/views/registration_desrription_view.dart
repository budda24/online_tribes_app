// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

// Package imports:

// Project imports:
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../../../helpers/assets/networkIng_images.dart';
import '../models/tribal_example.dart';
import 'registration_aditional_view.dart';
import 'registration_destription_hint_view_view.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final double screeanheight = MediaQuery.of(context).size.height;
    final double screeanwidth = MediaQuery.of(context).size.width;
    print('$screeanheight :: $screeanwidth'); */
    Get.find<RegistrationController>();

    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
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
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 16,
                          child: Container(
                            height: 445.h,
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: ListView.builder(
                                itemCount: TribeProfileExamples
                                    .listProfileDescriptionExamples.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        bottom: 10.h, top: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              DescriotionExamplePage(
                                                description: TribeProfileExamples
                                                    .listProfileDescriptionExamples[
                                                        index]
                                                    .description,
                                                title: TribeProfileExamples
                                                    .listProfileDescriptionExamples[
                                                        index]
                                                    .tribeName,
                                                imageUrl: TribeProfileExamples
                                                    .listProfileDescriptionExamples[
                                                        index]
                                                    .tribalSignPath,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 80.w,
                                            height: 80.h,
                                            margin: EdgeInsets.only(left: 20),
                                            child: Image.network(
                                                TribeProfileExamples
                                                    .listProfileDescriptionExamples[
                                                        index]
                                                    .tribalSignPath),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 38.w,
                                        ),
                                        Column(children: [
                                          Text(
                                            '${TribeProfileExamples.listProfileDescriptionExamples[index].userName}',
                                            style: kMontserratBold,
                                          ),
                                          Text(
                                            '${TribeProfileExamples.listProfileDescriptionExamples[index].tribeName}',
                                            style: kMontserratBold,
                                          ),
                                        ])
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        );
                      });
                },
                child: Image.asset(
                    'assets/images/authorization_screen/bulb_icon.png'),
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextField(
                onSave: () {},
                hintText: 'Describe yourself',
                maxline: 18,
                minLine: 2,
                height: 400.h,
                width: 400.w,
              ),
              SizedBox(
                height: 25.h,
              ),
              SlimRoundedButton(
                onPress: () {
                  Get.to(() => RegistrationAditionalView());
                },
                backgroundColour: kColorWhite,
                title: 'Continue',
                textColor: kTextColorDarkGrey,
                /* screenWidth: screeanwidth,
                      screenHeight: screeanheight */
              )
            ]),
          ),
        ),
      ),
    );
  }
}
