import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';

//  Neumorphic phoneCustomInput() {
//     return Neumorphic(
//       style: NeumorphicStyle(
//           depth: 10,
//           shadowDarkColor: AppColors.primaryColor,
//           color: Colors.transparent,
//           boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40))),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
//         child: InternationalPhoneNumberInput(
//           onInputChanged: (PhoneNumber value) {
//             number = value.phoneNumber!;
//           },
//           selectorConfig: const SelectorConfig(
//               setSelectorButtonAsPrefixIcon: true,
//               selectorType: PhoneInputSelectorType.DIALOG,
//               trailingSpace: true),
//           autoValidateMode: AutovalidateMode.disabled,
//           selectorTextStyle: const TextStyle(color: Colors.grey, fontSize: 16),
//           textFieldController: controller.phoneController,
//           formatInput: false,
//           textStyle: smallBold,
//           keyboardType: const TextInputType.numberWithOptions(
//               signed: true, decimal: true),
//           inputDecoration: const InputDecoration(
//             border: InputBorder.none,
//             hintText: 'Phone Number',
//           ),
//         ),
//       ),
//     );
//   }