/* // Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'dart:ui';

// Package imports:

// Project imports:
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../../../helpers/assets/networkIng_images.dart';
import '../models/tribal_example.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screeanheight = MediaQuery.of(context).size.height;
    final double screeanwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              MainCirclePhoto.networking(
                  /* imagePathL: '', */
                  imagePathN: AssetsUrl.exampleProfilePhoto,
                  screeanheight: screeanheight / 1.16,
                  screeanwidth: screeanwidth),
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
                            height: screeanheight * 0.57,
                            child: ListView.builder(
                                itemCount: TribeProfileExamples
                                    .listProfileDescriptionExamples.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    margin:
                                        EdgeInsets.only(bottom: 10, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 80,
                                            height: 80,
                                            margin: EdgeInsets.only(left: 20),
                                            child: Image.asset(TribeProfileExamples
                                                .listProfileDescriptionExamples[
                                                    index]
                                                .tribalSignPath)),
                                        SizedBox(
                                          width: screeanwidth * 0.097,
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
                onSave: () {},
                maxline: 50,
                minLine: 16,
                height: screeanheight,
                width: screeanwidth,
                hintText: '',
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



/* class TribeExamples {
  static List<TribeExamples> listProfileDescriptionExamples = [
    TribeExamples.profileDescription(
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Writer Tribe-01.png',
        tribeName: 'Writers Tribe',
        userName: 'Aetios'),
    TribeExamples.profileDescription(
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Musical Tribe-01.png',
        tribeName: 'Musical Tribe',
        userName: 'Hellena'),
    TribeExamples.profileDescription(
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Photography Tribe-01.png',
        tribeName: 'Photographer Tribe',
        userName: 'Achilles'),
    TribeExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Traveller Tribe-01.png',
        tribeName: 'Traveller Tribe',
        userName: 'Cornelius'),
    TribeExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Mothering Tribe-01.png',
        tribeName: 'Mothering Tribe',
        userName: 'Persephona'),
    TribeExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Illness Tribe-01.png',
        tribeName: 'Illnes Tribe',
        userName: 'Priam'),
    TribeExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Business Tribe-01.png',
        tribeName: 'Business Tribe',
        userName: 'Ajax'),
    TribeExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        tribalSignPath:
            'assets/images/authorization_screen/tribel_signs/Sign Artist Tribe-01.png',
        tribeName: 'Artist Tribe',
        userName: 'Lydhia'),
  ];

  TribeExamples.profileDescription(
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
    listProfileDescriptionExamples.add(TribeExamples.profileDescription(
        description: description,
        tribalSignPath: tribalSignPath,
        tribeName: tribeName,
        userName: userName));
  }
} */
 */