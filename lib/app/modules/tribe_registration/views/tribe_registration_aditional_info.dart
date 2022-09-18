// Package imports:

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/registration/registration_template.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/controllers/tribe_registration_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

// Project imports:
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/widgets/online_tribes/registration/custom_text_field.dart';
import '../../../helpers/widgets/online_tribes/registration/select_button.dart';
import '../controllers/tribe_registration_controller.dart';
import 'tribe_registration_upload_video_view.dart';

class RegistrationTribeAditionalInfo extends GetView {
  final globalController = Get.find<GlobalController>();
  final tribeRegistrationController = Get.find<TribeRegistrationController>();
  final videoController = Get.find<VideoViewerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: RegistrationTemplate(
        imagepath: tribeRegistrationController.localTribalSignPath,
        topElementsMargin: 100,
        buttonCallBack: () async {
          if (globalController.validateInput(
                  value: tribeRegistrationController.textNameController.text,
                  inputType: 'Tribal name',
                  lenght: 100) &&
              globalController.validateInput(
                  inputType: 'Triberers type',
                  value: tribeRegistrationController
                      .textTriberersTypeController.text,
                  lenght: 200)) {
            Get.to(RegistrationTribeUploadVideoView());
          }
        },
        centerWidget: Column(
          children: [
            GetBuilder<TribeRegistrationController>(
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
                          textFieldController: tribeRegistrationController
                              .textInputDialogControler,
                          savigInput: () {
                            getBuilderController.addTypeName();
                          }).showInputDialog();
                    },
                  ),
                ),
              ]);
            }),
            verticalSpace35,
            CustomTextField(
              textInputAction: TextInputAction.next,
              controller: tribeRegistrationController.textNameController,
              hintText: 'Tribe Name',
              maxline: 1,
              minLine: 1,
              height: 50.h,
              width: 500.w,
            ),
            verticalSpace25,
            CustomTextField(
              textInputAction: TextInputAction.next,
              controller:
                  tribeRegistrationController.textTriberersTypeController,
              hintText: 'Triberers Type',
              maxline: 4,
              minLine: 1,
              height: 130.h,
              width: 500.w,
            ),
          ],
        ),
      ),
    );
  }
}
