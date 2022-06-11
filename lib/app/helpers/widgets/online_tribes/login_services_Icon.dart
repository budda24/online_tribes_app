/* import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../registration_and_login/login_icons.dart';

class LoginServicesIcons extends StatelessWidget {
  final void onTapGoogle;
  LoginServicesIcons(
      {Key? key, required this.onTapGoogle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: const EdgeInsets.only(),
        child: LoginIcons.socialButtonCircle(
            AppColors.googleColor, FontAwesomeIcons.googlePlusG,
            iconColor: Colors.white, onTap: () {
          onTapGoogle;
        }),
      ),
    );
  }
} */
