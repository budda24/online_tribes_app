import 'package:flutter/material.dart';

import '../../../helpers/widgets/online_tribes/profile/rounded_bacgroud_container.dart';
import 'rounded_container.dart';

class NotificationTileAccepted extends StatelessWidget {
  const NotificationTileAccepted({
    Key? key,
  }) : super(key: key);

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
                      'assets/images/authorization_screen/tribel_signs/artist_tribe.png'),
                ),
              ),
              const Text('Drawers')
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 26,
                width: 36,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('assets/images/profile/shake_hands.png'),
                ),
              ),
              const Text(
                'Accepted',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          InkWell(
            onTap: () {
//TODO add logic
            },
            child: SizedBox(
                height: 40,
                width: 35,
                child: Image.asset('assets/images/profile/green_arrow.png')),
          ),
        ],
      ),
    );
  }
}
