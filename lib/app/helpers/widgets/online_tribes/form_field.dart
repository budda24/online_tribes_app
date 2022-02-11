import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';


import '../../main_constants.dart';
import '../../theme/text_styles.dart';

class CustomFormField extends StatelessWidget {
  final int lenght;
  final String displayedText;
  final TextEditingController controler;
  final Function saved;
  const CustomFormField({
    required this.lenght,
    required this.displayedText,
    required this.controler,
    required this.saved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controler,
      onSaved:(value)=> saved,
      maxLength: lenght,
      autofillHints: [AutofillHints.email],
      keyboardType: TextInputType.emailAddress,
      enableSuggestions: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: outlineInputTextFormFieldLabelStyle,
        hintStyle: outlineInputTextFormFieldHintStyle,
        enabledBorder:  UnderlineInputBorder(
          borderSide:  BorderSide(color: AppColors.blueColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.blueColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.blueColor),
        ),
        hintText: displayedText,
      ),
    );
  }
}
