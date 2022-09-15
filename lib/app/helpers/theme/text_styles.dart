// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'app_colors.dart';
import 'fonts.dart';

// Buttons
/* TextStyle buttonTextStyle = TextStyle(color: AppColors.blackColor);
TextStyle lightButtonTextStyle =
    popUpMessageStyle.copyWith(color: AppColors.whiteColor); */

// Headings

//online-tribes
TextStyle title = TextStyle(
    fontFamily: 'Futura Md BT', fontSize: 30.0.sp, fontWeight: FontWeight.bold);

TextStyle greenActionTitle = TextStyle(
    color: AppColors.actionColor,
    fontFamily: 'Futura Md BT',
    fontSize: 20.0.sp,
    fontWeight: FontWeight.bold);
TextStyle greenTitle = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: 'Futura Md BT',
    fontSize: 20.0.sp,
    fontWeight: FontWeight.bold);

TextStyle tribalFontLable = TextStyle(
    color: AppColors.actionColor,
    fontFamily: 'TribalDecorate',
    fontSize: 30.0.sp,
    fontWeight: FontWeight.bold);
TextStyle tribalFontLableWhite = TextStyle(
    color: AppColors.white,
    fontFamily: 'TribalDecorate',
    fontSize: 30.0.sp,
    fontWeight: FontWeight.bold);

TextStyle tribalFontLableRed = TextStyle(
    color: AppColors.errorRedColor,
    fontFamily: 'TribalDecorate',
    fontSize: 30.0.sp,
    fontWeight: FontWeight.bold);

TextStyle buttonLable = GoogleFonts.lato(
    textStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.w900));

TextStyle iconTextStyle = GoogleFonts.lato(
    textStyle: TextStyle(
        color: AppColors.blackColor,
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w900));

TextStyle headingBlackStyle = TextStyle(
    color: AppColors.blackColor,
    fontFamily: 'Montserrat',
    fontSize: 30.0.sp,
    fontWeight: FontWeight.bold);

TextStyle headingWhiteStyle = TextStyle(
  fontFamily: 'Montserrat',
  color: AppColors.white,
  fontWeight: FontWeight.bold,
  fontSize: 30.0.sp,
);
TextStyle headlineOneStyle = TextStyle(
  color: AppColors.blackColor,
  fontFamily: regular,
);
TextStyle headingBoldStyle = TextStyle(
    fontFamily: montserrat, fontSize: 20.0.sp, fontWeight: FontWeight.bold);

TextStyle tribalNameStyle = TextStyle(
    fontFamily: 'Futura Bk BT', fontSize: 30.0.sp, color: AppColors.white);

TextStyle plainTextStyle = TextStyle(
  fontSize: 18.0.sp,
  fontFamily: 'Leelawadee',
  fontWeight: FontWeight.bold,
  color: AppColors.blackColor,
);
TextStyle hintTextStyle = TextStyle(
  fontSize: 18.0.sp,
  fontFamily: 'Leelawadee',
  fontWeight: FontWeight.bold,
  color: AppColors.blackColor,
);
TextStyle popUpMessageStyle = TextStyle(
  color: AppColors.blackColor,
  fontFamily: regular,
);
TextStyle outlineInputTextFormFieldLabelStyle = TextStyle(
  fontFamily: futuraBkBT,
  fontSize: 30.0.sp,
  color: AppColors.white,
);
TextStyle outlineInputTextFormFieldHintStyle = TextStyle(
  color: AppColors.greyColor,
  fontSize: 16.sp,
  fontFamily: montserrat,
);
// text style
TextStyle kName = TextStyle(
    fontFamily: 'Futura Bk BT',
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: AppColors.white);

TextStyle textSHintStyle = GoogleFonts.lato(
    textStyle: TextStyle(
        color: AppColors.blackColor,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.w900));

TextStyle kHintStyleWhite = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  color: AppColors.white,
);
TextStyle kMontserratBold = const TextStyle(
  fontSize: 18,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const headingStyle = TextStyle(
  fontFamily: 'Built Relationship',
  fontSize: 30.0,
);

TextStyle smallBold = TextStyle(
  fontSize: 18.sp,
  fontFamily: montserrat,
  fontWeight: FontWeight.bold,
);

TextStyle smallTextStyle = TextStyle(
    fontFamily: poppins, fontSize: 13.0.sp, fontWeight: FontWeight.w300);
TextStyle longTextStyle = TextStyle(
  fontFamily: poppins,
  fontSize: 22.0.sp,
);
TextStyle textSActionColorSmall = TextStyle(
    color: AppColors.actionColor,
    fontFamily: leelawadee,
    fontSize: 13.0.sp,
    fontWeight: FontWeight.bold);
TextStyle textSBlackColorSmall = TextStyle(
    color: AppColors.blackColor,
    fontFamily: leelawadee,
    fontSize: 13.0.sp,
    fontWeight: FontWeight.bold);
TextStyle textSWhiteColorSmall = TextStyle(
    color: AppColors.white,
    fontFamily: leelawadee,
    fontSize: 13.0.sp,
    fontWeight: FontWeight.bold);

TextStyle lableWhite = TextStyle(
  fontFamily: regular,
  fontWeight: FontWeight.bold,
  fontSize: 30.0.sp,
  color: AppColors.white,
);

class TextSizing extends Text {
  const TextSizing(this.text, {Key? key, required this.size}) : super(text);
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: AppColors.blackColor, fontSize: size),
    );
  }
}

class TextContainerLable extends StatelessWidget {
  const TextContainerLable(
      {Key? key, required this.text, required this.lableStyle})
      : super(key: key);
  final String text;
  final TextStyle lableStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: lableStyle,
    );
  }
}



/*TextStyle textfieldStyle = TextStyle(
  fontSize: 20.0.sp,
  fontFamily: poppins,
  color: AppColors.greyColor,
);











*/


/*
TextStyle headlineTwoStyle = TextStyle(
  color: AppColors.blackColor,
  fontFamily: regular,
);

 TextStyle headlineThreeStyle = TextStyle(
  color: AppColors.blackColor,
  fontFamily: regular,
);

TextStyle headlineFourStyle = TextStyle(
  color: AppColors.blackColor,
  fontFamily: regular,
);



TextStyle latoWhite14 = TextStyle(
  color: AppColors.whiteColor,
  fontWeight: FontWeight.bold,
  fontFamily: regular,
);

TextStyle cardNumberTextStyle = TextStyle(
  color: AppColors.blackColor,
  fontFamily: regular,
);

TextStyle cardPercentTextStyle = TextStyle(
  color: AppColors.blueColor,
  fontFamily: regular, //To be Changed
);

TextStyle monserratRegularStyle = TextStyle(
  color: AppColors.whiteColor,
  fontFamily: regular,
  // fontWeight: FontWeight.w100,
);

TextStyle headlineFiveStyle = TextStyle(
  color: AppColors.blackColor,
  fontFamily: regular,
);

TextStyle monropeMediumStyle = TextStyle(
  color: AppColors.primaryColor,
  fontFamily: regular,
);

TextStyle cabinTitleStyle = TextStyle(
  color: AppColors.whiteColor,
  fontFamily: regular,
);

TextStyle cabinSmallStyle = TextStyle(
  color: AppColors.greyColor,
  fontFamily: regular,
);

TextStyle headlineTwoDarkStyle = TextStyle(
  color: AppColors.primaryColor,
  fontFamily: regular,
);

TextStyle monropeRegularSmall = TextStyle(
  color: AppColors.facebookColor,
  fontFamily: regular,
);

 TextStyle robotoHeading = TextStyle(
  color: AppColors.blackColor,
  fontFamily: regular,
);

TextStyle robotoSubHeading = TextStyle(
  color: AppColors.blackColor,
  fontFamily: regular,
  fontWeight: FontWeight.w400,
);

// Body

TextStyle bodyStyle = TextStyle(
  color: AppColors.whiteColor,
  fontFamily: regular,
);
TextStyle darkBodyStyle = TextStyle(
  color: AppColors.blackColor,
  fontFamily: regular,
); */

// Text Form Fields

