// Package imports:
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';

class RoundedExpandedContainer extends StatefulWidget {
  const RoundedExpandedContainer({
    Key? key,
    required this.containerHeight,
    required this.text,
    required this.heightToExpand,
    this.lable,
  }) : super(key: key);

  final int containerHeight;
  final String text;
  final int heightToExpand;
  final String? lable;

  @override
  State<RoundedExpandedContainer> createState() =>
      _RoundedExpandedContainerState();
}

class _RoundedExpandedContainerState extends State<RoundedExpandedContainer>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    animation = Tween<double>(
            begin: widget.containerHeight.toDouble() - 30,
            end: widget.containerHeight.toDouble() + widget.heightToExpand - 30)
        .animate(controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  bool isShrinkWrap = false;
  @override
  Widget build(BuildContext context) {
    void updateIsShrinkWrap() {
      setState(() {
        isShrinkWrap = !isShrinkWrap;
        switch (controller.status) {
          case AnimationStatus.completed:
            controller.reverse();
            break;
          case AnimationStatus.dismissed:
            controller.forward();
            break;
          default:
        }
      });
    }

    return Stack(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: !isShrinkWrap
            ? widget.containerHeight.toDouble()
            : widget.containerHeight.toDouble() + widget.heightToExpand,
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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
      Positioned.fill(
        top: animation.value,
        child: Align(
          alignment: Alignment.center,
          child: InkWell(
              onTap: () {
                updateIsShrinkWrap();
              },
              child: !isShrinkWrap
                  ? Image.asset('assets/images/profile/expand_more_arrow.png')
                  : Image.asset('assets/images/profile/expand_less_arrow.png')),
        ),
      ),
      widget.text == null
          ? const SizedBox.shrink()
          : Positioned.fill(
              top: -5,
              child: Align(
                alignment: Alignment.topCenter,
                child: TextContainerLable(text: widget.lable!),
              ),
            )
    ]);
  }
}
