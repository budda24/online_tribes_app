import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../main_constants.dart';
import '../../theme/text_styles.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.maxline,
    required this.minLine,
    required this.height,
    required this.width,
    required this.hintText,
  }) : super(key: key);

  final int minLine;
  final int maxline;
  final double height;
  final double width;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(411, 809),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    final _padding = EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w);
    final _margin =
        EdgeInsets.only(left: 40.w, right: 40.w, bottom: 20.h, top: 20.h);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.textFieldFill,
          ),
          height: height,
          width: width,
          margin: _margin,
          padding: _padding,
        ),
        Container(
          height: height,
          width: width,
          margin: _margin,
          padding: _padding,
          child: TextField(
            style: kTextfieldStyle,
            keyboardType: TextInputType.multiline,
            minLines: minLine,
            maxLines: maxline,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: kTextfieldStyle,
              filled: true,
              fillColor: AppColors.textFieldFill,
              hintText: hintText, /* contentPadding: EdgeInsets.all(15) */
            ),
          ),
        ),
      ],
    );
  }
}