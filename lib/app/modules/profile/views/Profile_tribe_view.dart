import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/neu_rounded_container.dart';
import 'package:flutter_application_1/app/modules/registration/widgets/neumorphic_circle_background.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../widgets/custom_navigation_bar.dart';

class ProfileTribeView extends GetView {
  final cameraController = Get.find<CameraController>();
  final profileController = Get.put(ProfileController());

  ProfileTribeView({Key? key}) : super(key: key);

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
              verticalSpaceMedium,
              NeumorphicCircleBackground(
                child: MainCirclePhoto.file(
                    screeanheight: 300.h,
                    screeanwidth: 250.w,
                    file: cameraController.pickedPhoto!),
              ),
              verticalSpaceLarge,
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: AppColors.whiteColor,
                ),
                width: double.infinity,
                height: 381.h,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 230,
                            child: NeuRoundedContainer(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: 'search',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Neumorphic(
                            style: const NeumorphicStyle(
                                depth: -10,
                                intensity: 20,
                                oppositeShadowLightSource: true),
                            child: InkWell(
                              onTap: () {
                                //TODO add search logic
                              },
                              child: Container(
                                width: 49,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.actionColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColors.greyColor, width: 1),
                                ),
                                child: const Icon(
                                  Icons.search,
                                  size: 37,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      NeuRoundedContainer(
                        height: 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assets/images/authorization_screen/tribel_signs/mothering_tribe.png'),
                              ),
                            ),
                            const Text(
                              'Mothers',
                              style: kHintStyle,
                            ),
                            SizedBox(
                                height: 40,
                                width: 35,
                                child: Image.asset(
                                    'assets/images/profile/letter.png')),
                          ],
                        ),
                      ),
                      NeuRoundedContainer(
                        height: 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assets/images/authorization_screen/tribel_signs/traveller_tribe.png'),
                              ),
                            ),
                            const Text(
                              'Travelers',
                              style: kHintStyle,
                            ),
                            SizedBox(
                                height: 40,
                                width: 35,
                                child: Image.asset(
                                    'assets/images/profile/letter.png')),
                          ],
                        ),
                      ),
                      NeuRoundedContainer(
                        height: 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assets/images/authorization_screen/tribel_signs/business_tribe.png'),
                              ),
                            ),
                            const Text(
                              'Pacemakers',
                              style: kHintStyle,
                            ),
                            SizedBox(
                                height: 40,
                                width: 35,
                                child: Image.asset(
                                    'assets/images/profile/letter.png')),
                          ],
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
