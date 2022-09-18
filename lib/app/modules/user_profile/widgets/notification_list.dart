// Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../controllers/user_profile_controller.dart';

class NotificationList extends StatelessWidget {
  NotificationList({Key? key}) : super(key: key);

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (builderController) {
        return SizedBox(
          height: 350,
          width: 500,
          child: AnimatedList(
            key: builderController.listKey,
            initialItemCount: builderController.notificationWidgets.length,
            itemBuilder: ((context, index, animation) {
              /* c.deletedIndex = index; */
              return builderController.buildItem(
                  builderController.notificationWidgets[index], animation, index);
            }),
          ),
        );
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
