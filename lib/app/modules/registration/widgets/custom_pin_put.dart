import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../helpers/theme/app_colors.dart';

class CustomPinPut extends StatelessWidget {
  CustomPinPut({required this.smsPinCode});

  TextEditingController smsPinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      pinAnimationType: PinAnimationType.fade,
      defaultPinTheme: _defaultPinTheme,
      focusedPinTheme: _focusedPinTheme,
      submittedPinTheme: _submittedPinTheme,
      showCursor: true,

      onCompleted: (pin) {
        smsPinCode.text = pin;
      },
    );
  }

  final PinTheme _defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primaryColor, width: 3),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final PinTheme _focusedPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final PinTheme _submittedPinTheme = PinTheme(
    width: 65,
    height: 65,
    textStyle: TextStyle(
        fontSize: 24, color: AppColors.whiteColor, fontWeight: FontWeight.bold),
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            AppColors.primaryColor,
            AppColors.actionColor,
          ],
        ),
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle),
  );
}
