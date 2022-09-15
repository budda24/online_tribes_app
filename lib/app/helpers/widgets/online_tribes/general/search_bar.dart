import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../modules/user_profile/widgets/rounded_container.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.searchCallback,
    required this.resetCallback,
    required this.hintText,
    required this.textEditingController,
  }) : super(key: key);

  final String hintText;
  final VoidCallback searchCallback;
  final VoidCallback resetCallback;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 205.w,
          child: RoundedContainer(
            height: 40.h.toInt(),
            child: Padding(
              padding: EdgeInsets.only(top: 0.h),
              child: TextFormField(
                style: textSHintStyle,
                controller: textEditingController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: outlineInputTextFormFieldHintStyle,
                  hintText: hintText,
                ),
              ),
            ),
          ),
        ),
        horizontalSpaceTiny,
        Column(
          children: [
            IconRoundedButton(
              calback: searchCallback,
              icon: Icon(
                Icons.search,
                size: 20.h,
              ),
            ),
            verticalSpaceTiny,
            IconRoundedButton(
              calback: resetCallback,
              icon: Icon(
                Icons.restore,
                size: 20.h,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class IconRoundedButton extends StatelessWidget {
  const IconRoundedButton({
    Key? key,
    required this.calback,
    required this.icon,
  }) : super(key: key);

  final VoidCallback calback;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        depth: -10,
        intensity: 20,
        oppositeShadowLightSource: true,
      ),
      child: InkWell(
        onTap: calback,
        child: Container(
            width: 40.h,
            height: 30.h,
            decoration: BoxDecoration(
              color: AppColors.actionColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.greyColor, width: 1),
            ),
            child: icon),
      ),
    );
  }
}
