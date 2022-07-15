// Flutter imports:
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
import '../widgets/neumorphic_circle_background.dart';
import '../widgets/tribe_examples_dialog.dart';
import 'registration_aditional_info_view.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';

class RegistrationDescriptionView extends GetView<RegistrationController> {
  final _formKey = GlobalKey<FormState>();

  @override
  final controller = Get.put(RegistrationController());
  final cameraController = Get.put(CameraController());
  final globalController = Get.find<GlobalController>();

  RegistrationDescriptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: globalController.unFocuseNode,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                         left: 30, right: 30, top: 10),
                    child: Column(
                      children: [
                        GetBuilder(
                          init: cameraController,
                          builder: (CameraController cameraCon) =>
                              cameraCon.pickedPhoto == null
                                  ? InkWell(
                                      child: NeumorphicCircleBackground(

                                        child: MainCirclePhoto.icon(
                                            screeanheight: 300.h,
                                            screeanwidth: 250.w,
                                            icon: Icon(
                                              Icons.add_a_photo_rounded,
                                              size: 40,
                                              color: AppColors.whiteColor,
                                            )),
                                      ),
                                      onTap: () async {
                                       showModalBottomSheet(
                                      context: context,
                                      backgroundColor: AppColors.transparent,
                                      builder: (BuildContext context) {
                                        return CustomPhotoPicker();
                                      });
                                      },
                                    )
                                  : NeumorphicCircleBackground(

                                      child: MainCirclePhoto.file(
                                        screeanheight: 10.h,
                                        screeanwidth: 10.w,
                                        file: cameraController.pickedPhoto!,
                                      ),
                                    ),
                        ),

                        verticalSpaceLarge,
                        CustomTextField(
                          controller: controller.describeYourselfController,
                          validate: (value) => controller.validateUser(
                              value: value, lenght: 1500),
                          hintText: 'Describe yourself',
                          maxline: 10,
                          minLine: 2,
                          height: 307.h,
                          width: 400.w,
                        ),
                        verticalSpaceLarge,
                        SlimRoundedButton(
                          onPress: () {
                            if (controller.checkIfPhotoUpload() &&
                                _formKey.currentState!.validate()) {
                              Get.to(() => RegistrationAditionalView());
                            }
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
                    top: 220,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const TribeExamplesDialog();
                            });
                      },
                      child: Image.asset(
                        'assets/images/authorization_screen/bulb_icon.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

