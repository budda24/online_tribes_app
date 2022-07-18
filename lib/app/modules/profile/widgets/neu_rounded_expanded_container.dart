import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/theme/app_colors.dart';
import '../controllers/profile_controller.dart';

class NeuRoundedExpandedContainer extends StatelessWidget {
  final profileController = Get.put(ProfileController());
  NeuRoundedExpandedContainer({
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
            onEnd: () {
              profileController.updateIsShrinkArrow();
            },
            width: double.infinity,
            child: Neumorphic(
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
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
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            left: 140,
            top: profCont.isShrinkArrow
                ? containerHeight.toDouble() - 30
                : containerHeight + 70,
            child: InkWell(
                onTap: () {
                  profileController.updateIsShrinkWrap();
                },
                child: profileController.isShrinkWrap
                    ? profileController.isShrinkArrow
                        ? Image.asset(
                            'assets/images/profile/expand_more_arrow.png')
                        : const SizedBox()
                    : !profileController.isShrinkArrow
                        ? Image.asset(
                            'assets/images/profile/expand_less_arrow.png')
                        : const SizedBox()),
          ),
        ],
      ),
    );
  }
}
