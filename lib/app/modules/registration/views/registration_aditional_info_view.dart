import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/registration/form_field.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_upload_video_view.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';

import '../../../helpers/widgets/online_tribes/registration/registration_template.dart';
import 'registration_upload_video_view.dart';

class RegistrationAditionalView extends GetView<RegistrationController> {
  final _formKey = GlobalKey<FormState>();

  final globalController = Get.find<GlobalController>();
  final cameraController = Get.find<CameraController>();

  RegistrationAditionalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplate(
      centerWidget:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        CustomTextField(
          textInputAction: TextInputAction.next,
          controller: controller.lifeMottoController,
          validate: (value) =>
              controller.validateUser(value: value, lenght: 200),
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
          validate: (value) =>
              controller.validateUser(value: value, lenght: 50),
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
          validate: (value) =>
              controller.validateUser(value: value, lenght: 50),
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
        controller.closeKeyboard();
        if (_formKey.currentState!.validate()) {
          /* Get.to(() => ProfileView()); */
          Get.to(RegistrationUploadVideoView());
        }
      },
    );
  }
}
