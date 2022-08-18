import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../helpers/theme/app_colors.dart';

class InviteUserTile extends StatelessWidget {
  InviteUserTile({required this.userImage, required this.userMotto, Key? key})
      : super(key: key);

  String userImage;
  String userMotto;
  bool? isInvided;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Neumorphic(
          margin: const EdgeInsets.symmetric(vertical: 10),
          style: NeumorphicStyle(
            shadowLightColorEmboss: AppColors.whiteColor,
            depth: -4,
            intensity: 5,
            oppositeShadowLightSource: true,
            shape: NeumorphicShape.convex,
            lightSource: LightSource.topLeft,
            border: NeumorphicBorder(width: 2, color: AppColors.primaryColor),
            shadowDarkColor: AppColors.darkGreyColor,
            color: isInvided != null
                ? AppColors.whiteColor
                : AppColors.primaryColor,
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
                        backgroundImage: NetworkImage(userImage),
                        radius: 35,
                        backgroundColor: AppColors.greyColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      userMotto,
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
                        isInvided = true;
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
              ))),
    );
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