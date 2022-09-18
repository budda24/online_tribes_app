// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

double mobileSize = 480;
double tabletSize = 767;
double largeTablet = 965;
double desktopSize = 1240;
double mediumDesktopSize = 1780;
double largeDesktopSize = 1780;

Widget horizontalSpace5 = SizedBox(width: 5.w);
Widget horizontalSpace10 = SizedBox(width: 10.w);
Widget horizontalSpace15 = SizedBox(width: 15.w);
Widget horizontalSpace25 = SizedBox(width: 25.w);
Widget horizontalSpace50 = SizedBox(width: 50.w);
Widget horizontalSpace70 = SizedBox(width: 70.w);

Widget verticalSpace10 = SizedBox(height: 10.0.h);
Widget verticalSpace15 = SizedBox(height: 15.0.h);
Widget verticalSpace20 = SizedBox(height: 20.0.h);
Widget verticalSpace25 = SizedBox(height: 25.0.h);
Widget verticalSpace40 = SizedBox(height: 40.0.h);
Widget verticalSpace35 = SizedBox(height: 35.0.h);
Widget verticalSpace50 = SizedBox(height: 50.0.h);
Widget verticalSpace65 = SizedBox(height: 65.0.h);
Widget verticalSpace120 = SizedBox(height: 120.0.h);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

bool isDesktop(BuildContext context) => screenWidth(context) > tabletSize;
bool isMobile(BuildContext context) => screenWidth(context) <= mobileSize;

double screenHeightFraction(
  BuildContext context, {
  double dividedBy = 1,
  double offsetBy = 0,
}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(
  BuildContext context, {
  double dividedBy = 1,
  double offsetBy = 0,
}) =>
    (screenWidth(context) - offsetBy) / dividedBy;
