// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
import '../controllers/tribe_registration_controller.dart';

class TribalSignPicker extends StatelessWidget {
  final tribeRegistrationController = Get.find<TribeRegistrationController>();

  TribalSignPicker();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          /* print('customPicker');
          CustomPhotoPicker(); */
        },
        child: Stack(
          children: [
            SizedBox(
              height: 110.h,
              width: 80.w,
              child: tribeRegistrationController.uploadedTribalSign != null
                  ? Image.asset(tribeRegistrationController.uploadedTribalSign!)
                  : Image.asset(cAddCustomSignSign),
            ),
          ],
        ),
      ),
    );
  }
}
