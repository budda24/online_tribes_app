import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../modules/profile/widgets/rounded_container.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.controller,
    required this.searchCalback,
  }) : super(key: key);

  final Function? searchCalback;
  final GetxController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200.w,
          child: RoundedContainer(
            height: 40.h.toInt(),
            child: Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: hintTextStyle,
                  hintText: 'search',
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Neumorphic(
          style: const NeumorphicStyle(
              depth: -10, intensity: 20, oppositeShadowLightSource: true),
          child: InkWell(
            onTap: () {
              //TODO add search logic
            },
            child: Container(
              width: 49.h,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.actionColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyColor, width: 1),
              ),
              child: Icon(
                Icons.search,
                size: 37.h,
              ),
            ),
          ),
        )
      ],
    );
  }
}
