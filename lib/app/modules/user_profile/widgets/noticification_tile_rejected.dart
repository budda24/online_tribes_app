// Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../controllers/user_profile_controller.dart';
import 'rounded_container.dart';

class NotificationTileRejected extends StatelessWidget {
  NotificationTileRejected({
    required this.tribeId,
    Key? key,
  }) : super(key: key);

  var profileController = Get.find<ProfileController>();

  String tribeId;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              SizedBox(
                height: 26,
                width: 26,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                      'assets/images/authorization_screen/tribel_signs/writer_tribe.png'),
                ),
              ),
              const Text('Inkers')
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 26,
                width: 26,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('assets/images/profile/happy_face.png'),
                ),
              ),
              const Text(
                'Rejected',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          InkWell(
            onTap: () async {
              await profileController.deleteNotification(tribeId);

              //TODO add logic delete
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
