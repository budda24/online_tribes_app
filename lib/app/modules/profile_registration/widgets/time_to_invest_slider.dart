// Package imports:
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/theme/app_colors.dart';

// ignore: must_be_immutable
class TimeToInvestSlider extends StatelessWidget {
  TimeToInvestSlider({
    Key? key,
    required this.sliderValue,
  }) : super(key: key);

  RxDouble sliderValue;

  @override
  Widget build(BuildContext context) {
    return Obx(() => NeumorphicSlider(
          thumb: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Stack(
              children: [
                SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      'assets/images/authorization_screen/logo/50x50.png',
                    )),
                Positioned(
                    right: 15,
                    top: 5,
                    child: Text(
                      sliderValue.toStringAsFixed(0),
                      style: kMontserratBold,
                    ))
              ],
            ),
          ),
          height: 24,
          min: 1,
          max: 7,
          value: sliderValue.value,
          onChanged: (value) {
            sliderValue.value = value;
          },
          style: SliderStyle(
            border: NeumorphicBorder(color: AppColors.white, width: 1),
            accent: AppColors.actionColor,
            variant: AppColors.primaryColor,
          ),
        ));
  }
}
