/* // Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
import 'user_registration_aditional_info_view.dart';
import 'user_registration_upload_video_view.dart';
import '../models/country_model.dart';

class RegistrationAdressInfoView
    extends GetView<ProfileRegistrationController> {
  final _formKey = GlobalKey<FormState>();

  final globalController = Get.find<GlobalController>();
  final cameraController = Get.find<CameraController>();

  RegistrationAdressInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('RegistrationAdressInfoView build');
    return RegistrationTemplate(
      topElementsMargin: 50,
      centerWidget:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                margin: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  bottom: 5.h,
                ),
                child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: controller.textCountryController,
                      decoration: InputDecoration(
                        /* labelText:  'Country', */
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: textSHintStyle,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Country',
                      ),
                    ),
                    onSuggestionSelected: (Country country) {},
                    itemBuilder: (_, Country country) {
                      return Container(
                        decoration: BoxDecoration(
                            border: BoxBorder.lerp(null, null, 2)),
                        child: Text(
                          country.name,
                          style: headingBlackStyle,
                        ),
                      );
                    },
                    suggestionsCallback: (pattern) {
                      return controller.getSuggestions(pattern);
                    }),
              ));
        }),
      ]),
      buttonCallBack: () {
        globalController.unFocuseNode();
        if (true) {
          //TODO check the validity of adress
          Get.to(() => RegistrationAditionalView());
          /* Get.to(RegistrationUploadVideoView()); */
        }
      },
    );
  }
}
 */
