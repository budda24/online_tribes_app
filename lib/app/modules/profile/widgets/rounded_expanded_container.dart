import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import '../controllers/profile_controller.dart';

class RoundedExpandedContainer extends StatelessWidget {
  final profileController = Get.put(ProfileController());
  RoundedExpandedContainer({
    Key? key,
    required this.containerHeight,
    required this.text,
  }) : super(key: key);

  final int containerHeight;

  final String text;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profCont) => Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: profCont.isShrinkWrap
                ? containerHeight.toDouble()
                : containerHeight.toDouble() + 100,
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
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 0.8.sw,
                height: containerHeight.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: SingleChildScrollView(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: plainTextStyle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 140,
            top: profCont.isShrinkWrap
                ? containerHeight.toDouble() - 25
                : containerHeight + 75,
            child: InkWell(
              onTap: () {
                // profCont.isShrinkWrap = !profCont.isShrinkWrap;
                // profCont.forceUpdate();
                profileController.updateIsShrinkWrap();
              },
              child: const Icon(
                Icons.expand_more,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
