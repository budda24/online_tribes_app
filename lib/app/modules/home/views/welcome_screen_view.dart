
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/home_controller.dart';

// Flutter imports:


// Package imports:
import 'package:get/get.dart';



// Project imports:
import 'welcome_screen2_view.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/bacground_waves_thene.dart';
import '../../../helpers/widgets/online_tribes/row_progress_dott.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';


class WelcomeView1 extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final double screeanheight = MediaQuery.of(context).size.height;
    final double screeanwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
          Stack(
            children: [
              GreenWaves1(screeanheight:screeanheight ),
              Container(
                margin: EdgeInsets.only(top: screeanheight*0.07),
                child: Center(
                  child: Image.asset(
                    'assets/images/welcome_screans/screen_1.png',
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
                'Create or Join \n your tribe',
                textAlign: TextAlign.center,
                style: kHeading,
              ),
            ),
          ),
          SizedBox(height: screeanheight * 0.09),
          Center(
            child: SlimRoundedButton(
              onPress:Get.to(SecondScreen()),
              title: 'Continue',
              backgroundColour: kColorBlue,
              textColor: kColorWhite,
            ),
          ),
          SizedBox(
            height: screeanheight * 0.05,
          ),
          Center(
            child: RowProgressDots(
              screeanheight: screeanheight,
              screeanwidth: screeanwidth,
              dott1: kMainColor,
              dott2: kMainColorOpacity40,
              dott3: kMainColorOpacity40,
            ),
          ),
        ])));
  }
}
