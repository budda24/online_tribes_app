// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/user_registration/views/user_registration_adress_info.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/camera_controller.dart';
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/widgets/online_tribes/registration/custom_text_field.dart';
import '../../../helpers/widgets/online_tribes/registration/registration_template.dart';
import '../controllers/user_registration_controller.dart';
import '../models/country_model.dart';
import 'user_registration_aditional_info_view.dart';

class RegistrationDescriptionView
    extends GetView<ProfileRegistrationController> {
  RegistrationDescriptionView({Key? key}) : super(key: key);

  final cameraController = Get.put(CameraController());
  final globalController = Get.find<GlobalController>();

  @override
  final controller = Get.put(ProfileRegistrationController());

  final _formKey = GlobalKey<FormState>();

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    print('RegistrationDescriptionView');
    rebuildAllChildren(context);
    return RegistrationTemplate(
      topElementsMargin: 50,
      centerWidget: Column(
        children: [
          GetBuilder<ProfileRegistrationController>(
              builder: (getBuilderController) {
            return Neumorphic(
                style: NeumorphicStyle(
                  shadowLightColorEmboss: AppColors.primaryColor,
                  depth: -5,
                  shape: NeumorphicShape.convex,
                  lightSource: LightSource.topLeft,
                  intensity: 60,
                  color: AppColors.white,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
                ),
                child: Container(
                  height: 50.h,
                  width: 500.w,
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                  margin: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    bottom: 5.h,
                  ),
                  child: TypeAheadFormField(
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          shadowColor: AppColors.actionColor,
                          color: AppColors.white),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textFieldConfiguration: TextFieldConfiguration(
                        textAlign: TextAlign.center,
                        controller: controller.textCountryController,
                        style: textSHintStyle,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: textSHintStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'country',
                        ),
                      ),
                      onSuggestionSelected: (Country country) {
                        controller.userDB.country = country;
                        controller.textCountryController.text = country.name;
                        controller.update();
                      },
                      itemBuilder: (_, Country country) {
                        return Column(
                          children: [
                            Text(
                              country.name,
                              textAlign: TextAlign.center,
                              style: hintTextStyle,
                            ),
                            Divider(
                              color: AppColors.primaryColor,
                              height: 10,
                              thickness: 3,
                            )
                          ],
                        );
                      },
                      suggestionsCallback: (pattern) {
                        return controller.getSuggestions(pattern);
                      }),
                ));
          }),
          verticalSpace15,
          CustomTextField(
            controller: controller.textNameController,
            textInputAction: TextInputAction.next,
            hintText: 'Name',
            maxline: 1,
            minLine: 1,
            height: 45.h,
            width: 500.w,
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomTextField(
            controller: controller.textDescribtionController,
            hintText: 'Describe yourself',
            maxline: 12,
            minLine: 8,
            height: 200.h,
            width: 400.w,
          ),
        ],
      ),
      formKey: _formKey,
      buttonCallBack: () {
        if (controller.checkIfPhotoChosen() &&
            globalController.validateInput(
                value: controller.textDescribtionController.text,
                lenght: 1500,
                inputType: 'description') &&
            globalController.validateInput(
                value: controller.textNameController.text,
                lenght: 50,
                inputType: "Name")) {
          Get.to(() => RegistrationAditionalView());
        }
      },
    );
  }
}
