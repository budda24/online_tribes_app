// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/camera_controller.dart';
import '../../../controllers/global_controler.dart';
import '../../../helpers/widgets/online_tribes/registration/custom_text_field.dart';
import '../../../helpers/widgets/online_tribes/registration/registration_template.dart';
import '../controllers/profile_registration_controller.dart';
import 'registration_upload_video_view.dart';

class RegistrationAditionalView extends GetView<ProfileRegistrationController> {
  final _formKey = GlobalKey<FormState>();

  final globalController = Get.find<GlobalController>();
  final cameraController = Get.find<CameraController>();

  RegistrationAditionalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplate(
      topElementsMargin: 100,
      centerWidget:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        CustomTextField(
          textInputAction: TextInputAction.next,
          controller: controller.lifeMottoController,
          hintText: 'The Life Motto',
          maxline: 6,
          minLine: 1,
          height: 130.h,
          width: 500.w,
        ),
        SizedBox(
          height: 15.h,
        ),
        CustomTextField(
          controller: controller.hobby1Controller,
          textInputAction: TextInputAction.next,
          hintText: 'Hobby 1',
          maxline: 1,
          minLine: 1,
          height: 50.h,
          width: 500.w,
        ),
        SizedBox(
          height: 15.h,
        ),
        CustomTextField(
          controller: controller.hobby2Controller,
          textInputAction: TextInputAction.next,
          hintText: 'Hobby 2',
          maxline: 1,
          minLine: 1,
          height: 50.h,
          width: 500.w,
        ),
      ]),
      formKey: _formKey,
      buttonCallBack: () {
        globalController.unFocuseNode();
        if (controller.validateAditionalInfo()) {
          /* Get.to(() => ProfileView()); */
          Get.to(RegistrationUploadVideoView());
        }
      },
    );
  }
}