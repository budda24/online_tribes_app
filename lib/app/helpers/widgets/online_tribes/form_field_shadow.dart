import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';

class CustomTextFormFieldShadow extends StatelessWidget {
  const CustomTextFormFieldShadow(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.maxLenght,
      this.isPassword = false,
      this.textInputType = TextInputType.emailAddress})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final int maxLenght;
  final bool isPassword;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          depth: 10,
          shadowDarkColor: AppColors.primaryColor,
          color: Colors.transparent,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40))),
      child: TextField(
        controller: controller,
        maxLength: maxLenght,
        obscureText: isPassword,
        autofillHints: const [AutofillHints.email],
        keyboardType: textInputType,
        enableSuggestions: true,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
            isDense: true,
            hintText: hintText,
            hintStyle: plainTextStyle,
            counterText: "",
            border: InputBorder.none),
      ),
    );
  }
}
