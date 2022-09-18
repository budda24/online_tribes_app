// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/camera_controller.dart';
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/alert_styles.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/widgets/online_tribes/registration/custom_text_field.dart';
import '../../../helpers/widgets/online_tribes/registration/registration_template.dart';
import '../../../helpers/widgets/online_tribes/registration/select_button.dart';
import '../controllers/user_registration_controller.dart';
import 'user_registration_upload_video_view.dart';

class RegistrationAditionalView extends GetView<ProfileRegistrationController> {
  final _formKey = GlobalKey<FormState>();

  final globalController = Get.find<GlobalController>();
  final cameraController = Get.find<CameraController>();

  RegistrationAditionalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('RegistrationAditionalView build');
    return RegistrationTemplate(
      topElementsMargin: 100,
      centerWidget:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        GetBuilder<ProfileRegistrationController>(
            builder: (getBuilderController) {
          return Stack(children: [
            Positioned(
                child: SizedBox(
              height: 70,
              width: 0.9.sw,
            )),
            Positioned(
              bottom: 0,
              child: SelectButton(
                value: getBuilderController.chosenTribalType,
                onChange: (newValue) {
                  getBuilderController.chosenTribalType = newValue!;
                  getBuilderController.update();
                },
                items: getBuilderController.tribalTypes.map(
                  (item) {
                    return DropdownMenuItem<String>(
                      alignment: AlignmentDirectional.center,
                      value: item,
                      child: Center(
                        child: Text(
                          item,
                          style: kHintStyleWhite,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            Positioned(
              top: -5,
              right: -5,
              child: IconButton(
                icon: CircleAvatar(
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.add,
                      color: AppColors.actionColor,
                      size: 30,
                    )),
                onPressed: () async {
                  await Alerts.textInput(
                      onConfirm: () {},
                      title: '',
                      content: '',
                      textFieldController:
                          getBuilderController.textInputDialogControler,
                      savigInput: () {
                        getBuilderController.addTypeName();
                      }).showInputDialog();
                },
              ),
            ),
          ]);
        }),
        verticalSpace15,
        CustomTextField(
          textInputAction: TextInputAction.next,
          controller: controller.textLifeMottoController,
          hintText: 'The Life Motto',
          maxline: 6,
          minLine: 1,
          height: 130.h,
          width: 500.w,
        ),
        verticalSpace15,
        CustomTextField(
          controller: controller.textHobbyController,
          textInputAction: TextInputAction.next,
          hintText: 'Hobby 1',
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
