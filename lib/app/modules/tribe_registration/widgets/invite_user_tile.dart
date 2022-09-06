import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/controllers/tribe_registration_controller.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/views/invite_user_detal_view.dart';
import 'package:flutter_application_1/infrastructure/fb_services/models/user_model.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';

class InviteUserTile extends StatelessWidget {
  InviteUserTile({required this.user, Key? key}) : super(key: key);
  UserDB user;
  @override
  Widget build(BuildContext context) {
    var neumorficStyle = NeumorphicStyle(
      color: user.isInvited == false ? AppColors.primaryColor : AppColors.white,
      shadowLightColorEmboss: AppColors.white,
      depth: -4,
      intensity: 5,
      oppositeShadowLightSource: true,
      shape: NeumorphicShape.convex,
      lightSource: LightSource.topLeft,
      border: NeumorphicBorder(width: 2, color: AppColors.primaryColor),
      shadowDarkColor: AppColors.darkGreyColor,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
    );

    return InkWell(
      onTap: () {
        Get.to(InviteUserDetailView(), arguments: user);
      },
      child: GetBuilder<TribeRegistrationController>(
        builder: (builderController) {
          return Neumorphic(
            margin: const EdgeInsets.symmetric(vertical: 10),
            style: neumorficStyle,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 37.r,
                      backgroundColor: user.isInvited == false
                          ? AppColors.white
                          : AppColors.primaryColor,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(user.profilePhotoRef!.downloadUrl),
                        radius: 35.r,
                        backgroundColor: AppColors.greyColor,
                      ),
                    ),
                    verticalSpaceTiny,
                    FittedBox(
                      child: Text(user.hobbies!.hobby, style: kMontserratBold),
                    ),
                    const SizedBox(height: 3),
                    MaterialButton(
                      height: 24,
                      minWidth: 110,
                      onPressed: () async {
                        var tribeId = builderController.tribeDB.tribeId;

                        builderController.updateInvitationUsersList(
                            user, tribeId);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: user.isInvited == false
                          ? AppColors.actionColor
                          : AppColors.primaryColor,
                      child: Text(
                        user.isInvited == false ? 'Invite' : 'Invited',
                        style: TextStyle(
                          color: user.isInvited == false
                              ? AppColors.white
                              : AppColors.blackColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
