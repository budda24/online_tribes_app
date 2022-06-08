/* import 'package:flutter/material.dart';
// Flutter imports:


// Package imports:
import 'package:get/get.dart';



// Project imports:

import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/bacground_waves_thene.dart';
import '../../../helpers/widgets/online_tribes/row_progress_dott.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screeanheight = MediaQuery
        .of(context)
        .size
        .height;
    final double screeanwidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Stack(
                children: [
                  GreenWaves2(screeanheight: screeanheight),
                  Container(
                    margin: EdgeInsets.only(top: screeanheight*0.035),
                    child: Center(
                      child: Image.asset(
                        'assets/images/welcome_screans/screen_2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  child: Text(
                    'Built \n Relationship',
                    textAlign: TextAlign.center,
                    style: kHeading,
                  ),
                ),
              ),
              SizedBox(height: screeanheight * 0.09),
              Center(
                child: SlimRoundedButton(
                  title: 'Continue',
                  backgroundColour: kColorBlue,
                  textColor: kColorWhite,
                ),
              ),
              SizedBox(
                height: screeanheight * 0.05,
              ),
              Center(
                child: RowProgressDots(screeanheight: screeanheight, screeanwidth: screeanwidth, dott1: kMainColorOpacity40, dott2: kMainColor, dott3: kMainColorOpacity40,),
              ),
            ])
        )
    );
  }
}
 */