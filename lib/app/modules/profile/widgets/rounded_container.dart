// Package imports:
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    required this.height,
    required this.child,
    this.lable,
  }) : super(key: key);

  final int height;
  final Widget child;
  final String? lable;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Neumorphic(
        margin: const EdgeInsets.symmetric(vertical: 10),
        style: NeumorphicStyle(
          shadowLightColorEmboss: AppColors.primaryColor,
          /* shadowLightColor: AppColors.darkGreyColor, */
          depth: -5,
          shape: NeumorphicShape.convex,
          lightSource: LightSource.topLeft,
          intensity: 60,
          /* shadowDarkColor: AppColors.darkGreyColor, */
          color: AppColors.whiteColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          width: 0.8.sw,
          height: height.h,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: child,
        ),
      ),
      lable == null
          ? const SizedBox.shrink()
          : Positioned.fill(
            top: -15,
              child: Align(
                alignment: Alignment.topCenter,
                child: TextContainerLable(text: lable!,lableStyle: tribalFontLable,),
              ),
            )
    ]);
  }
}
