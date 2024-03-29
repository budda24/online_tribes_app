import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../modules/authorization/controllers/login_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';

class PhoneNumberInput extends StatelessWidget {
  PhoneNumberInput(
      {Key? key,
      required this.controller,
      required this.isEnabled,
      /* this.initialNumber */})
      : super(key: key);

  final LoginController controller;
  /* PhoneNumber? initialNumber; */
  final isEnabled;

  @override
  Widget build(BuildContext context) {
    /* print('initialNumber dialCode: ${initialNumber!.dialCode}');
    print('initialNumber isoCode: ${initialNumber!.isoCode}');
    print('initialNumber phoneNumber: ${initialNumber!.phoneNumber}'); */
    return Neumorphic(
      style: NeumorphicStyle(
          depth: 10,
          shadowDarkColor: AppColors.primaryColor,
          color: Colors.transparent,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: InternationalPhoneNumberInput(
          isEnabled: isEnabled,
          onSaved: (PhoneNumber value) {
            controller.numberToVerify = value;
          },
          onInputChanged: (PhoneNumber value) {},
          selectorConfig: const SelectorConfig(
              setSelectorButtonAsPrefixIcon: true,
              selectorType: PhoneInputSelectorType.DIALOG,
              trailingSpace: true),
          autoValidateMode: AutovalidateMode.disabled,
          initialValue: controller.numberToVerify,
          ignoreBlank: true,
          selectorTextStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          textFieldController: controller.phoneTextEditingController,
          formatInput: false,
          textStyle: smallBold,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          inputDecoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Phone Number',
          ),
        ),
      ),
    );
  }
}
