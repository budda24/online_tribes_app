// Package imports:
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/theme/app_colors.dart';

class RoundedInputContainer extends StatelessWidget {
  const RoundedInputContainer({
    Key? key,
    required this.height,
    required this.hintText,
    required this.textController,
    required this.validate,
  }) : super(key: key);

  final int height;
  final String hintText;
  final FormFieldValidator? validate;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 10),
      style: NeumorphicStyle(
        shadowLightColorEmboss: AppColors.primaryColor,
        /* shadowLightColor: AppColors.darkGreyColor, */
        depth: -5,
        shape: NeumorphicShape.convex,
        lightSource: LightSource.topLeft,
        intensity: 60,
        /* shadowDarkColor: AppColors.darkGreyColor, */
        color: AppColors.white,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20.r)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: 0.8.sw,
        height: height.h,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextFormField(
          controller: textController,
          validator: validate,
          style: kMontserratBold,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintStyle: kHintStyle,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
