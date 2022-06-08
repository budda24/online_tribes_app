import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';

class OneLineTextField extends StatelessWidget {
  final String lable;
  final Function onsaved;
  final Function? validator;
  final TextEditingController controller;
  final bool isOscure;
  OneLineTextField({
    Key? key,
    required this.lable,
    required this.onsaved,
    this.validator,
    required this.controller,
    this.isOscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      height: 50.h,
      width: 320.w,
      child: TextFormField(
        obscureText: isOscure,
        controller: controller,
        validator: (text) => validator!(text),
        onSaved: (text) => onsaved(text),
        decoration: InputDecoration(
            label: Text(
              lable,
              style: textfieldLableStyle,
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(40.r),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(40.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(40.r),
            ),
            filled: true,
            fillColor: Colors.white70),
      ),
    );
  }
}
