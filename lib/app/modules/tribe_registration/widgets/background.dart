import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.h,
            left: -20.w,
            child: Image.asset(
              'assets/images/tribe_registration/icon1.2.png',
              height: 90.h,
            ),
          ),
          Positioned(
            top: 10.h,
            right: 0.w,
            child: Image.asset(
              'assets/images/tribe_registration/icon1.4.png',
              height: 90.h,
            ),
          ),
          Positioned(
            top: 200.h,
            right: -40.w,
            child: Image.asset(
              'assets/images/tribe_registration/icon1.3.png',
              height: 280.h,
            ),
          ),
          Positioned(
            bottom: 40.h,
            left: 20.w,
            child: Image.asset(
              'assets/images/tribe_registration/icon1.1.png',
              height: 80.h,
            ),
          ),
          child
        ],
      ),
    );
  }
}
