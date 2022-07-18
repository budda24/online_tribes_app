import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';

class RoundedExpandedContainer extends StatefulWidget {
  const RoundedExpandedContainer({
    Key? key,
    required this.containerHeight,
    required this.text,
  }) : super(key: key);

  final int containerHeight;

  final String text;

  @override
  State<RoundedExpandedContainer> createState() =>
      _RoundedExpandedContainerState();
}

class _RoundedExpandedContainerState extends State<RoundedExpandedContainer> {
  /* final profileController = Get.put(ProfileController()); */
  bool isShrinkWrap = false;

  @override
  Widget build(BuildContext context) {
    void updateIsShrinkWrap() {
      setState(() {
        isShrinkWrap = !isShrinkWrap;
      });
    }

    return Stack(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: isShrinkWrap
            ? widget.containerHeight.toDouble()
            : widget.containerHeight.toDouble() + 100,
        width: double.infinity,
        child: Neumorphic(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          style: NeumorphicStyle(
            shadowLightColorEmboss: AppColors.primaryColor,
            depth: -5,
            shape: NeumorphicShape.convex,
            lightSource: LightSource.topLeft,
            intensity: 60,
            color: AppColors.whiteColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: 0.8.sw,
            height: widget.containerHeight.h,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SingleChildScrollView(
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: plainTextStyle,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: 140,
        top: isShrinkWrap //
            ? widget.containerHeight.toDouble() - 25
            : widget.containerHeight + 75,
        child: Positioned(
          left: 140,
          top: isShrinkWrap
              ? widget.containerHeight.toDouble() - 30
              : widget.containerHeight + 70,
          child: InkWell(
              onTap: () {
                updateIsShrinkWrap();
              },
              child: isShrinkWrap
                  ? Image.asset('assets/images/profile/expand_more_arrow.png')
                  : Image.asset('assets/images/profile/expand_less_arrow.png')),
        ),
      )
    ]);
  }
}
