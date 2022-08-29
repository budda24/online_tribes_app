// Package imports:

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/registration/registration_template.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

// Project imports:
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/widgets/online_tribes/registration/form_field.dart';
import '../controllers/tribe_registration_controller.dart';
import 'registration_tribe_upload_video_view.dart';

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
          if (await tribeRegistrationController.validateInput(
                  value: tribeRegistrationController.textNameController.text,
                  inputType: 'Tribal name',
                  lenght: 100) &&
              await tribeRegistrationController.validateInput(
                  inputType: 'Tribal purpous',
                  value: tribeRegistrationController.textPurpousController.text,
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
                      value: getBuilderController.chosenTribaType,
                      onChange: (newValue) {
                        getBuilderController.chosenTribaType = newValue!;
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
                      ).toList()),
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: IconButton(
                    icon: CircleAvatar(
                        backgroundColor: AppColors.whiteColor,
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
            verticalSpaceMediumThree,
            CustomTextField(
              textInputAction: TextInputAction.next,
              controller: tribeRegistrationController.textNameController,
              hintText: 'Tribe Name',
              maxline: 1,
              minLine: 1,
              height: 50.h,
              width: 500.w,
            ),
            verticalSpaceMedium,
            CustomTextField(
              textInputAction: TextInputAction.next,
              controller: tribeRegistrationController.textPurpousController,
              hintText: 'Tribe purpous',
              maxline: 2,
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

class SelectButton extends StatelessWidget {
  const SelectButton({
    Key? key,
    required this.items,
    required this.value,
    required this.onChange,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChange;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        hint: Row(
          children: [
            Icon(
              Icons.list,
              size: 16,
              color: AppColors.actionColor,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select Type',
                style: plainTextStyle,
              ),
            ),
          ],
        ),
        isExpanded: true,
        items: items,
        value: value,
        onChanged: onChange,
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: AppColors.whiteColor,
        iconDisabledColor: AppColors.whiteColor,
        buttonHeight: 50,
        buttonWidth: 0.70.sw,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black26,
          ),
          color: AppColors.actionColor,
        ),
        buttonElevation: 2,
        itemHeight: 40,
        dropdownMaxHeight: 300,
        alignment: AlignmentDirectional.topCenter,
        barrierColor: AppColors.whiteColor,
        dropdownWidth: 0.72.sw,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.actionColor,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
      ),
    );
  }
}
