// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../widgets/custom_photo_picker.dart';
import '../widgets/tribe_examples_dialog.dart';
import 'registration_aditional_info_view.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';

class RegistrationDescriptionView extends GetView<RegistrationController> {
  RegistrationDescriptionView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(RegistrationController());
  final cameraController = Get.put(CameraController());
  @override
  Widget build(BuildContext context) {
    Get.put(RegistrationController);

    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 30, left: 30, right: 30, top: 10),
                child: Column(
                  children: [
                    GetBuilder(
                      init: cameraController,
                      builder: (CameraController cameraCon) =>
                          cameraCon.pickedFile == null
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
                                              return CustomPhotoPicker(
                                                type: PickedType.photo,
                                              );
                                            })
                                        .then((value) => controller.uploadFile(
                                            directory: 'profile',
                                            fileName: 'profile_photo'));
                                  },
                                )
                              : MainCirclePhoto.file(
                                  screeanheight: 300.h,
                                  screeanwidth: 250.w,
                                  file: cameraCon.pickedFile!),
                    ),
                    const Text(
                      'Cornelius',
                      style: kName,
                    ),
                    verticalSpaceMedium,
                    CustomTextField(
                      onSave: () {},
                      hintText: 'Describe yourself',
                      maxline: 10,
                      minLine: 2,
                      height: 300.h,
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
                  ],
                ),
              ),
              Positioned(
                top: 200,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const TribeExamplesDialog();
                        });
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.actionColor,
                    radius: 25,
                    child: Image.asset(
                      'assets/images/authorization_screen/bulb_icon.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
