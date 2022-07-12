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

  final int minLine;
  final int maxline;
  final double height;
  final double width;
  String? hintText;
  String? lableText;

  Function? onSave;
  TextEditingController? controller;
  Color? color;
  FormFieldValidator? validate;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        surfaceIntensity: 0.9,
        shadowLightColorEmboss: Colors.white,
        shadowLightColor: AppColors.primaryColor,
        depth: -5,
        shape: NeumorphicShape.convex,
        lightSource: LightSource.bottomRight,
        intensity: 45,
        shadowDarkColor: Colors.black,
        color: AppColors.whiteColor,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
      ),
      child: Container(
        height: height.h,
        width: width.w,
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        margin: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 5.h, top: 5.h),
        child: Container(
          margin: EdgeInsets.all(8),
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
      ),
    );
  }
}
