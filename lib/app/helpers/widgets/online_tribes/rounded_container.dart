import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';

class RoundedContainer extends StatelessWidget {
  RoundedContainer({
    Key? key,
    required this.screanHeight,
    required this.screanWidth,
    this.child = const Text(''),
    this.bcColor = Colors.transparent,
    required this.height,
    /* required this.width, */
  }) : super(key: key);
  /* double width; */
  double height;
  double screanHeight;
  double screanWidth;
  Widget child;
  Color bcColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      /* width: width, */
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bcColor,
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(
            left: screanWidth * 0.1,
            right: screanWidth * 0.1,
            bottom: screanWidth * 0.05,
            top: screanWidth * 0.05),
        child: child);
  }
}
