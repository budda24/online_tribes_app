import 'package:flutter/material.dart';

import '../../../helpers/theme/ui_helpers.dart';
import 'rounded_container.dart';

class NotificationTileInvited extends StatelessWidget {
  const NotificationTileInvited({
    Key? key,
  }) : super(key: key);

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
          horizontalSpaceMedium,
          Column(
            children: [
              SizedBox(
                height: 26,
                width: 36,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                      'assets/images/profile/invited_sign.png'),
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
                    child: Image.asset(
                        'assets/images/profile/confirm_sign.png')),
              ),
              InkWell(
                onTap: () {
                  //TODO add logic for refuse
                },
                child: SizedBox(
                    height: 40,
                    width: 35,
                    child: Image.asset(
                        'assets/images/profile/refuse_sign.png')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
