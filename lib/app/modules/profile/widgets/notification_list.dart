// Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../controllers/profile_controller.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (c) {
        return SizedBox(
          height: 300,
          width: 500,
          child: Column(
            children: [...c.notificationWidgets],
          ),
        );
      },
    );
  }
}
