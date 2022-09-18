import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';

class SelectButton extends StatelessWidget {
  const SelectButton({
    Key? key,
    required this.items,
    required this.value,
    required this.onChange,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChange;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        hint: Row(
          children: [
            Icon(
              Icons.list,
              size: 16,
              color: AppColors.actionColor,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select Type',
                style: plainTextStyle,
              ),
            ),
          ],
        ),
        isExpanded: true,
        items: items,
        value: value,
        onChanged: onChange,
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: AppColors.white,
        iconDisabledColor: AppColors.white,
        buttonHeight: 50,
        buttonWidth: 0.70.sw,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black26,
          ),
          color: AppColors.actionColor,
        ),
        buttonElevation: 2,
        itemHeight: 40,
        dropdownMaxHeight: 300,
        alignment: AlignmentDirectional.topCenter,
        barrierColor: AppColors.white,
        dropdownWidth: 0.72.sw,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.actionColor,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
      ),
    );
  }
}
