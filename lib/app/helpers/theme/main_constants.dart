import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// theme colors
const kMainColor = Color(0xff8FFCBB);
const kMainColorOpacity40 = Color(0xffD2FEE4);

const kTextColorGrey = Color(0xffAFC1CC);
const kTextColorDarkGrey = Color(0xff808080);

const Color googleColor = Color(0xffDF4A32);
const Color facebookColor = Color(0xff39579A);

const kColorWhite = Colors.white;
const kColorBlue = Color(0xff82ACEA);
const kDark = Color(0xff000000);


const kTextCheckBox =
    TextStyle(fontSize: 10, fontFamily: 'Regular', color: kTextColorGrey);

Image kBottomNavBarGreenMarker =
    Image.asset('assets/images/profile/elipse.png');

const String cConfirmSign = 'assets/images/profile/confirm_sign.png';
const String cMotheringTribeSign =
    'assets/images/tribel_signs/mothering_tribe.png';
const String cMusicalTribeSign =
    'assets/images/tribel_signs/musical_tribe.png';
const String cTravellerTribeSign =
    'assets/images/tribel_signs/traveller_tribe.png';
const String cArtistTribeSign =
    'assets/images/tribel_signs/artist_tribe.png';
const String cBussinessTribeSign =
    'assets/images/tribel_signs/business_tribe.png';
const String cWriteringTribeSign =
    'assets/images/tribel_signs/writer_tribe.png';
const String cIllnessTribeSign =
    'assets/images/tribel_signs/illness_tribe.png';
const String cAddCustomSignSign =
    'assets/images/tribe_registration/add_custom_sign.png';

var spinkit = SpinKitSpinningLines(
  color: AppColors.actionColor,
  size: 80.0,
);

const int oneLineContainerHeight = 60;
