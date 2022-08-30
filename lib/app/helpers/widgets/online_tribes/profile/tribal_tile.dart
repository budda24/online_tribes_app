import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';

import '../../../../modules/user_profile/widgets/rounded_container.dart';
import '../../../theme/main_constants.dart';

class TribeTile extends StatelessWidget {
  const TribeTile({
    Key? key,
    required this.letterCallback,
    required this.tribalName,
    required this.tribalSign,
  }) : super(key: key);

  final Image tribalSign;
  final String tribalName;
  final Function letterCallback;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: FittedBox(
              fit: BoxFit.fill,
              child: tribalSign,
            ),
          ),
          Text(
            tribalName,
            style: kHintStyle,
          ),
          InkWell(
            onTap: letterCallback(),
            child: SizedBox(
                height: 40,
                width: 35,
                child: Image.asset('assets/images/profile/letter.png')),
          ),
        ],
      ),
    );
  }
}