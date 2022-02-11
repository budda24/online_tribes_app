// Flutter imports:
import 'package:flutter/material.dart';
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
import 'registration_destription_hint_view_view.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final double screeanheight = MediaQuery.of(context).size.height;
    final double screeanwidth = MediaQuery.of(context).size.width;
    print('$screeanheight :: $screeanwidth'); */

    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
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
              CustomTextField(
                hintText: 'Describe yourself',
                maxline: 50,
                minLine: 16,
                height: 781.h,
                width: 392.w,
              ),
              SlimRoundedButton(
                onPress: () {},
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

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.maxline,
    required this.minLine,
    required this.height,
    required this.width,
    required this.hintText,
  }) : super(key: key);
  int minLine;
  int maxline;
  double height;
  double width;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: width * 0.1,
          right: width * 0.1,
          bottom: width * 0.05,
          top: width * 0.05),
      child: TextField(
        style: kTextfieldStyle,
        keyboardType: TextInputType.multiline,
        minLines: minLine,
        maxLines: maxline,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintStyle: kTextfieldStyle,
            filled: true,
            fillColor: Color(0xffCBFAE2),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            hintText: hintText,
            contentPadding: EdgeInsets.all(15)),
      ),
    );
  }
}

/* class TribeProfileExamples {
  static List<TribeProfileExamples> listProfileDescriptionExamples = [
    TribeProfileExamples.profileDescription(
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Writer Tribe-01.png',
        tribeName: 'Writers Tribe',
        userName: 'Aetios'),
    TribeProfileExamples.profileDescription(
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Musical Tribe-01.png',
        tribeName: 'Musical Tribe',
        userName: 'Hellena'),
    TribeProfileExamples.profileDescription(
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Photography Tribe-01.png',
        tribeName: 'Photographer Tribe',
        userName: 'Achilles'),
    TribeProfileExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Traveller Tribe-01.png',
        tribeName: 'Traveller Tribe',
        userName: 'Cornelius'),
    TribeProfileExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Mothering Tribe-01.png',
        tribeName: 'Mothering Tribe',
        userName: 'Persephona'),
    TribeProfileExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Illness Tribe-01.png',
        tribeName: 'Illnes Tribe',
        userName: 'Priam'),
    TribeProfileExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Business Tribe-01.png',
        tribeName: 'Business Tribe',
        userName: 'Ajax'),
    TribeProfileExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Artist Tribe-01.png',
        tribeName: 'Artist Tribe',
        userName: 'Lydhia'),
  ];

  TribeProfileExamples.profileDescription(
      {required this.description,
      required this.tribalSignPath,
      required this.tribeName,
      required this.userName});

  String tribalSignPath;
  String userName;
  String tribeName;
  String description;

  void addProfileDescription(String description, String tribeName,
      String userName, String tribalSignPath) {
    listProfileDescriptionExamples.add(TribeProfileExamples.profileDescription(
        description: description,
        tribalSignPath: tribalSignPath,
        tribeName: tribeName,
        userName: userName));
  }
}
 */