import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../modules/user_profile/widgets/rounded_container.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {Key? key,
      required this.searchCalback,
      required this.hintText,
      required this.textEditingController})
      : super(key: key);

  final String hintText;
  final VoidCallback searchCalback;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 205.w,
          child: RoundedContainer(
            height: 30.h.toInt(),
            child: Padding(
              padding: EdgeInsets.only(top: 0.h),
              child: TextFormField(
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
        const Spacer(),
        Neumorphic(
          style: const NeumorphicStyle(
            depth: -10,
            intensity: 20,
            oppositeShadowLightSource: true,
          ),
          child: InkWell(
            onTap: searchCalback,
            //TODO add search logic

            child: Container(
              width: 49.h,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColors.actionColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyColor, width: 1),
              ),
              child: Icon(
                Icons.search,
                size: 30.h,
              ),
            ),
          ),
        )
      ],
    );
  }
}
