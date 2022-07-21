import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/rounded_container.dart';
import 'package:flutter_application_1/app/modules/registration/widgets/neumorphic_circle_background.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
<<<<<<< HEAD
import '../widgets/custom_navigation_bar.dart';
import '../widgets/noticification_tile_accepted.dart';
import '../widgets/noticification_tile_invited.dart';
import '../widgets/noticification_tile_rejected.dart';

class ProfileNotyficationsView extends GetView {
  final cameraController = Get.find<CameraController>();
  final profileController = Get.find<ProfileController>();
=======

class ProfileNotyficationsView extends GetView<CameraController> {

   final profileController = Get.find<ProfileController>();
>>>>>>> fc806697f3aaad5c56101b8266e9dbfb7cf71d21

  ProfileNotyficationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpaceTiny,
            NeumorphicCircleBackground(
                child: MainCirclePhoto.networking(
                    imageSize: 125,
                    screeanheight: 300.h,
                    screeanwidth: 250.w,
                    imagePathN: profileController.profilePhoto),
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
              height: 400.h,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Column(
                  children: [
                    RoundedContainer(
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
                    ),
                    RoundedContainer(
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
                                  child: Image.asset(
                                      'assets/images/profile/shake_hands.png'),
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
                                child: Image.asset(
                                    'assets/images/profile/green_arrow.png')),
                          ),
                        ],
                      ),
                    ),
                    RoundedContainer(
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
                                  child: Image.asset(
                                      'assets/images/profile/happy_face.png'),
                                ),
                              ),
                              const Text(
                                'Invited',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




