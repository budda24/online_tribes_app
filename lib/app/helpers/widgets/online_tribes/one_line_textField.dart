import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OneLineTextField extends StatelessWidget {
  final String lable;
  final Function onsaved;
  final Function? validator;
  final TextEditingController controller;
  OneLineTextField({
    Key? key,
    required this.lable,
    required this.onsaved,
    this.validator,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      height: 50.h,
      width: 320.w,
      child: TextFormField(
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
