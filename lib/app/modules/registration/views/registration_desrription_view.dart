// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Package imports:

// Project imports:
import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../models/tribal_example.dart';
import 'registration_aditional_info_view.dart';
import 'registration_destription_hint_view_view.dart';

class RegistrationDescriptionView extends GetView<RegistrationController> {
  RegistrationDescriptionView({Key? key}) : super(key: key);
  final cameraController = Get.put(CameraGetXController());
  @override
  Widget build(BuildContext context) {
    print(auth.currentUser!.email);
    Get.put(RegistrationController);

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Align(
                alignment: Alignment.topCenter,
                child: GetBuilder(
                  init: cameraController,
                  builder: (CameraGetXController cameraCon) =>
                      Column(children: [
                    cameraCon.image == null
                        ? InkWell(
                            child: MainCirclePhoto.icon(
                                screeanheight: 300.h,
                                screeanwidth: 250.w,
                                icon: Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 40,
                                  color: AppColors.whiteColor,
                                )),
                            onTap: () async {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Card(
                                      color: AppColors.textFieldFill,
                                      child: Container(
                                        height: 100,
                                        color: AppColors.textFieldFill,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    await cameraController
                                                        .getImageGallery();
                                                  },
                                                  icon: Icon(
                                                    Icons.photo_album,
                                                    size: 50.h,
                                                  ),
                                                ),
                                                verticalSpaceTiny,
                                                Text(
                                                  '   Gallery',
                                                  style: headingBoldStyle,
                                                )
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    await cameraController
                                                        .getImageCamera();
                                                  },
                                                  icon: Icon(
                                                    Icons.camera,
                                                    size: 50.h,
                                                  ),
                                                ),
                                                verticalSpaceTiny,
                                                Text(
                                                  '   Camera',
                                                  style: headingBoldStyle,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          )
                        : MainCirclePhoto.file(
                            screeanheight: 300.h,
                            screeanwidth: 250.w,
                            file: cameraCon.image!),
                  ]),
                ),
              ),
              const Text(
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
                                    .listTribeProfileExamples.length,
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
                                              DescriptionExamplePage(
                                                description: TribeProfileExamples
                                                    .listTribeProfileExamples[
                                                        index]
                                                    .description,
                                                title: TribeProfileExamples
                                                    .listTribeProfileExamples[
                                                        index]
                                                    .tribeName,
                                                imageAssetPath:
                                                    TribeProfileExamples
                                                        .listTribeProfileExamples[
                                                            index]
                                                        .imageAssetPath,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 80.w,
                                            height: 80.h,
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            child: Image.asset(
                                                TribeProfileExamples
                                                    .listTribeProfileExamples[
                                                        index]
                                                    .imageAssetPath),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 38.w,
                                        ),
                                        Column(children: [
                                          Text(
                                            TribeProfileExamples
                                                .listTribeProfileExamples[index]
                                                .userName,
                                            style: kMontserratBold,
                                          ),
                                          Text(
                                            TribeProfileExamples
                                                .listTribeProfileExamples[index]
                                                .tribeName,
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
                maxline: 10,
                minLine: 2,
                height: 200.h,
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
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
