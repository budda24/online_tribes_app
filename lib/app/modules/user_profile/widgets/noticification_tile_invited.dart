//Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/theme/ui_helpers.dart';
import '../controllers/user_profile_controller.dart';
import 'rounded_container.dart';

class NotificationTileInvited extends StatelessWidget {
  NotificationTileInvited({
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
        children: [
          Column(
            children: [
              SizedBox(
                height: 26,
                width: 26,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                      'assets/images/authorization_screen/tribel_signs/business_tribe.png'),
                ),
              ),
              const Text('Peacemakers')
            ],
          ),
          horizontalSpace25,
          Column(
            children: [
              SizedBox(
                height: 26,
                width: 36,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('assets/images/profile/invited_sign.png'),
                ),
              ),
              const Text(
                'Invited',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Spacer(),
          Row(
            children: [
              InkWell(
                onTap: () {
                  //TODO add logic for accept
                },
                child: SizedBox(
                    height: 40,
                    width: 35,
                    child:
                        Image.asset('assets/images/profile/confirm_sign.png')),
              ),
              InkWell(
                onTap: () async {
                  await profileController.deleteNotification(tribeId);

                  //TODO add logic for refuse
                },
                child: SizedBox(
                    height: 40,
                    width: 35,
                    child:
                        Image.asset('assets/images/profile/refuse_sign.png')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
