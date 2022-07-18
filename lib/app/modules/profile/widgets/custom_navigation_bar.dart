import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/main_constants.dart';
import '../../../helpers/theme/app_colors.dart';
import 'bottom_nav_bar_item.dart';


class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({
    Key? key,
    required this.actualIndex,
  }) : super(key: key);

  RxInt actualIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border(
              top: BorderSide(
            color: Colors.black26 ,
            width: 2,
          ))),
      child: Obx(() => Stack(
            children: [
              Positioned(

                  left: 45,
                  top: 5,
                  child: actualIndex.value == 1
                      ? kBottomNavBarGreenMarker
                      : const SizedBox()),
              Positioned(
                  left: 165,
                   top: 5,
                  child: actualIndex.value == 2
                      ? kBottomNavBarGreenMarker
                      : const SizedBox()),
              Positioned(
                  right: 45,
                   top: 5,
                  child: actualIndex.value == 3
                      ? kBottomNavBarGreenMarker
                      : const SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavBarItem(
                      onTap: () {
                        actualIndex.value = 1;
                      },
                      title: 'My Profile',
                      imagePath: 'assets/images/profile/tribe.png'),
                  BottomNavBarItem(
                      onTap: () {
                        actualIndex.value = 2;
                      },
                      title: 'Notifications',
                      imagePath: 'assets/images/profile/bell.png'),
                  BottomNavBarItem(
                      onTap: () {
                        actualIndex.value = 3;
                      },
                      title: 'My Tribe',
                      imagePath: 'assets/images/profile/tent.png'),
                ],
              ),
            ],
          )),
    );
  }
}
