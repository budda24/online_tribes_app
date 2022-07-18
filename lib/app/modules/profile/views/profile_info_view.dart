import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/registration/widgets/neumorphic_circle_background.dart';


import '../controllers/profile_controller.dart';
import 'chuiw_example.dart';

class ProfileInfoView extends GetView<ProfileController> {
  ProfileInfoView({Key? key}) : super(key: key);

  final cameraController = Get.find<CameraController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              NeumorphicCircleBackground(
                child: MainCirclePhoto.icon(
                    screeanheight: 300.h,
                    screeanwidth: 250.w,
                    icon: Icon(
                      Icons.add_a_photo_rounded,
                      size: 40,
                      color: AppColors.whiteColor,
                    )),
              ),
              SizedBox(
                height: 40.h,
              ),
              verticalSpaceMedium,
              Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: AppColors.whiteColor,
                  ),
                  width: double.infinity,
                  height: 500.h,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Obx(() {
                            return ExpandedContainer(
                              
                              containerHeight:
                                  controller.descriptionHight.value,
                              text: lorum ,

                              },
                            );
                          })
                        ],
                      ),

                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
