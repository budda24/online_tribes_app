import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main_constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.maxline,
    required this.minLine,
    required this.height,
    required this.width,
    this.hintText,
     this.onSave,
    this.controller,
    this.color,
    this.lableText,
    this.validate
  }) : super(key: key);

  Color? color;
  TextEditingController? controller;
  final double height;
  String? hintText;
  String? lableText;
  final int maxline;
  final int minLine;
  Function? onSave;
  FormFieldValidator? validate;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        surfaceIntensity:0.0,
        shadowLightColorEmboss: AppColors.darkGreyColor,
        /* shadowLightColor: AppColors.darkGreyColor, */
        depth: -5,
        shape: NeumorphicShape.convex,
        lightSource: LightSource.topLeft,
        intensity: 60,
        /* shadowDarkColor: AppColors.darkGreyColor, */
        color: AppColors.whiteColor,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
      ),
      child: Container(
        height: height.h,
        width: width.w,
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        margin: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 5.h, ),
        child: TextFormField(
          validator: validate,
          controller: controller,
          style: kHintStyle,
          keyboardType: TextInputType.multiline,
          minLines: minLine,
          maxLines: maxline,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            labelText: lableText ?? '',
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
