/* import 'package:flutter/material.dart';

import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';

import '../../../helpers/widgets/online_tribes/main_button.dart';

import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

import 'package:get/get.dart';

import 'description_hint_view.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screeanheight = MediaQuery.of(context).size.height;
    final double screeanwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
                /*mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,*/
                children: [
                  MainCirclePhoto.networking(
                      /* imagePathL: '', */
                      imagePathN:
                          'https://i.ibb.co/bNSDLBR/IMG-20200717-143747.jpg" alt="IMG-20200717-143747',
                      screeanheight: screeanheight / 1.16,
                      screeanwidth: screeanwidth),
                  Text(
                    'Cornelius',
                    style: lable,
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
                                height: screeanheight * 0.57,
                                child: ListView.builder(
                                    itemCount: TribeExamples
                                        .listProfileDescriptionExamples.length,
                                    itemBuilder: (_, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(DescriotionExamplePage());
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: 10, top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 80,
                                                  height: 80,
                                                  margin:
                                                      EdgeInsets.only(left: 20),
                                                  child: Image.asset(TribeExamples
                                                      .listProfileDescriptionExamples[
                                                          index]
                                                      .tribalSignPath)),
                                              SizedBox(
                                                width: screeanwidth * 0.097,
                                              ),
                                              Column(children: [
                                                Text(
                                                  '${TribeExamples.listProfileDescriptionExamples[index].userName}',
                                                  style: montserratBold,
                                                ),
                                                Text(
                                                  '${TribeExamples.listProfileDescriptionExamples[index].tribeName}',
                                                  style: montserratBold,
                                                ),
                                              ])
                                            ],
                                          ),
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
                  CustomTextField(
                    maxline: 50,
                    minLine: 16,
                    height: screeanheight,
                    width: screeanwidth,
                  ),
                  SlimRoundedButton(
                    onPress: () {},
                    backgroundColour: AppColors.whiteColor,
                    title: 'Continue',
                    textColor: AppColors.greyColor,
                    /* creenWidth: screeanwidth,
                      screenHeight: screeanheight */
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.maxline,
      required this.minLine,
      required this.height,
      required this.width})
      : super(key: key);
  int minLine;
  int maxline;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: width * 0.1,
          right: width * 0.1,
          bottom: width * 0.05,
          top: width * 0.05),
      child: TextField(
        style: textfieldStyle,
        keyboardType: TextInputType.multiline,
        minLines: minLine,
        maxLines: maxline,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintStyle: textfieldStyle,
            filled: true,
            fillColor: Color(0xffCBFAE2),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            hintText: 'Describe Yourself',
            contentPadding: EdgeInsets.all(15)),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  final double screeanheight = MediaQuery.of(context).size.height;
  final double screeanwidth = MediaQuery.of(context).size.width;
  return Scaffold(
    backgroundColor: AppColors.primaryColor,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainCirclePhoto(
                  imagePathL: '',
                  imagePathN:
                      'https://dsm01pap004files.storage.live.com/y4mSAO3WBYornQDxwsVjGtgVpcoJNz5Y9ITQ3fP-GDujvO9AZVRXxmBIKjhin7XOdO2W9gL8Gdh_RlPV3D_-CavMYsLqiRAp5pjEscR1WnOaAr-2xFPBqahZub3s8muZcS-_2Mi_-mEGHve_UFzRWyxedKxdXw2GDtx_dmT9t_y5292inuqdAFwe5LXnT3wyvqL?width=2448&height=3264&cropmode=none',
                  /* imagePathL:'assets/images/authorization_screen/tribel_signs/Sign Business Tribe-01.png', */
                  screeanheight: screeanheight / 1.6,
                  screeanwidth: screeanwidth),
              Text(
                'Cornelius',
                style: heading,
              ),
            ]),
      ),
    ),
  );
} */
