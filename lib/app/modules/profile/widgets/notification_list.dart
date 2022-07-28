// Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../controllers/profile_controller.dart';

class NotificationList extends StatelessWidget {
  NotificationList({Key? key}) : super(key: key);

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (c) {
        return SizedBox(
            height: 300,
            width: 500,
            child: AnimatedList(
              key: c.listKey,
              initialItemCount: c.notificationWidgets.length,
              itemBuilder: ((context, index, animation) {
                c.deletedIndex = index;
                return c.buildItem(
                    c.notificationWidgets[index], animation, index);
              }),
            ));
      },
    );
  }

  // _buildItem(Widget item, Animation<double> animation, int index) {
  //   return SizeTransition(
  //     sizeFactor: animation,
  //     child: item,
  //   );
  // }

  // void _removeItem(int i) {
  //   Widget removedItem = profileController.notificationWidgets.removeAt(i);
  //   AnimatedListRemovedItemBuilder builder = (context, animation) {
  //     return _buildItem(removedItem, animation, i);
  //   };
  //   listKey.currentState!.removeItem(i, builder);
  // }
}
