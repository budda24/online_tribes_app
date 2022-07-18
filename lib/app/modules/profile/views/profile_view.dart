import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/neu_rounded_container.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/neu_rounded_expanded_container.dart';
import 'package:flutter_application_1/app/modules/registration/widgets/neumorphic_circle_background.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../widgets/custom_navigation_bar.dart';

class ProfileView extends GetView {
  final cameraController = Get.find<CameraController>();
  final profileController = Get.put(ProfileController());

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          CustomNavigationBar(actualIndex: profileController.actualIndex),
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              verticalSpaceTiny,
              NeumorphicCircleBackground(
                child: MainCirclePhoto.file(
                    screeanheight: 300.h,
                    screeanwidth: 250.w,
                    file: cameraController.pickedPhoto!),
              ),
              verticalSpaceSmall,
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: AppColors.whiteColor,
                ),
                width: double.infinity,
                height: 426.h,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
                  child: Column(
                    children: [
                      NeuRoundedExpandedContainer(

                          containerHeight: 120,
                          text: 'text',
                         ),
                      const NeuRoundedContainer(
                        height: 55,
                        child: Center(
                          child: Text(
                            'Tribal name',
                            style: kHintStyle,
                          ),
                        ),
                      ),
                      const NeuRoundedContainer(
                        height: 45,
                        child: Center(
                          child: Text(
                            'Hobby 1',
                            style: kHintStyle,
                          ),
                        ),
                      ),
                      const NeuRoundedContainer(
                        height: 45,
                        child: Center(
                          child: Text(
                            'Hobby 1',
                            style: kHintStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
