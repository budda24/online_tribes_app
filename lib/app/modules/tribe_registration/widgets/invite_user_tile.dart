import 'package:flutter_application_1/app/modules/tribe_registration/controllers/tribe_registration_controller.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/views/invite_user_detal_view.dart';
import 'package:flutter_application_1/infrastructure/fb_services/models/user_model.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../../helpers/theme/app_colors.dart';

class InviteUserTile extends StatelessWidget {
  InviteUserTile({required this.user, Key? key}) : super(key: key);

  UserDB user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(InviteUserDetailView(), arguments: user);
        },
        child: GetBuilder<TribeRegistrationController>(
          builder: (builderController) => Neumorphic(
            margin: const EdgeInsets.symmetric(vertical: 10),
            style: NeumorphicStyle(
              color: user.isInvited == null || false
                  ? AppColors.primaryColor
                  : AppColors.whiteColor,
              shadowLightColorEmboss: AppColors.whiteColor,
              depth: -4,
              intensity: 5,
              oppositeShadowLightSource: true,
              shape: NeumorphicShape.convex,
              lightSource: LightSource.topLeft,
              border: NeumorphicBorder(width: 2, color: AppColors.primaryColor),
              shadowDarkColor: AppColors.darkGreyColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 37,
                      backgroundColor: AppColors.whiteColor,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(user.profilePhoto!.downloadUrl),
                        radius: 35,
                        backgroundColor: AppColors.greyColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      user.lifeMotto!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                          fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    MaterialButton(
                      height: 24,
                      minWidth: 110,
                      onPressed: () {
                        if (user.isInvited == null) {
                          user.isInvited = true;
                        } else {
                          user.isInvited = !user.isInvited!;
                        }
                        builderController.rebuildWidget;

                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: AppColors.actionColor,
                      child: Text(
                        'Invite',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

 /* Neumorphic(
        margin: const EdgeInsets.symmetric(vertical: 10),
        style: NeumorphicStyle(
          shadowLightColorEmboss: AppColors.primaryColor,
          /* shadowLightColor: AppColors.darkGreyColor, */
          depth: -5,
          shape: NeumorphicShape.convex,
          lightSource: LightSource.topLeft,
          intensity: 60,
          /* shadowDarkColor: AppColors.darkGreyColor, */
          color: AppColors.whiteColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          width: 0.8.sw,
          height: height.h,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: child,
        ),
      ), */