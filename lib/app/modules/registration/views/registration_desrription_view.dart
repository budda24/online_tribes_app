// Flutter imports:
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/camea_controller.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';

import '../../../helpers/widgets/online_tribes/registration/form_field.dart';
import '../../../helpers/widgets/online_tribes/registration/registration_template.dart';
import 'registration_aditional_info_view.dart';

class RegistrationDescriptionView extends GetView<RegistrationController> {
  final _formKey = GlobalKey<FormState>();

  @override
  final controller = Get.put(RegistrationController());
  final cameraController = Get.put(CameraController());
  final globalController = Get.find<GlobalController>();

  RegistrationDescriptionView({Key? key}) : super(key: key);
  void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }
  (context as Element).visitChildren(rebuild);
}
  @override
  Widget build(BuildContext context) {
     rebuildAllChildren(context);
    return RegistrationTemplate(
      centerWidget: CustomTextField(
        controller: controller.describtionController,
        validate: (value) =>
            controller.validateUser(value: value, lenght: 1500),
        hintText: 'Describe yourself',
        maxline: 12,
        minLine: 8,
        height: 280.h,
        width: 400.w,
      ),
      formKey: _formKey,
      buttonCallBack: () {
        /* Get.to(TribeRegistrationChoice()); */

        if (controller.checkIfPhotoUpload() &&
            _formKey.currentState!.validate()) {
          /* Get.to(() => ProfileView()); */

          Get.to(() => RegistrationAditionalView());
        }
      },
    );
  }
}
