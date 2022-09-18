import 'package:flutter_application_1/app/modules/user_profile/widgets/rounded_container.dart';
import 'package:flutter_application_1/infrastructure/native_functions/time_converting_services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/fb_services/models/tribe_model.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../../user_profile/widgets/rounded_expanded_container.dart';
import '../../user_profile/widgets/video_player.dart';
import '../controllers/tribe_profile_controller.dart';

class TribeProfileView extends GetView<TribeProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: GetBuilder<TribeProfileController>(builder: (getController) {
          TribeDb? tribeDb = controller.tribeDb;
          TribeProfileSection section = getController.selectedSection;

          return ProfileTemplate(
            swichTabs: TribeProfileTabs(
              currantSectionIndex: controller.selectedSection.index,
              switchSection: controller.switchSections,
            ),
            containerPadding:
                PaddingParameters(horizontal: 20.w, vertical: 10.h),
            videoPlayer: section == TribeProfileSection.info
                ? GetBuilder<TribeProfileController>(
                    builder: (builderController) {
                    return tribeDb!.tribalIntroVideo!.downloadUrl != ''
                        ? builderController.videoController != null
                            ? CustomVideoPlayer.network(
                                type: VideoAsset.network,
                                videoSrc: tribeDb.tribalIntroVideo!.downloadUrl,
                                videoController:
                                    builderController.videoController)
                            : const SizedBox.shrink()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              spinkit,
                              const SizedBox(height: 20),
                              const Text('Loading'),
                            ],
                          );
                  })
                : null,
            profileImage: tribeDb!.customTribalSign == null
                ? Image.asset(tribeDb.localTribalSign!)
                : Image.network(tribeDb.customTribalSign!.downloadUrl),
            title: Text(
              tribeDb.tribalName!,
              style: tribalFontLable,
            ),
            fields: section == TribeProfileSection.info
                ? [
                    verticalSpace20,
                    Text(
                      'Availability',
                      style: tribalFontLable,
                    ),
                    AvailableTimeRow(tribeDb: tribeDb),
                    RoundedExpandedContainer(
                      lable: 'Triberers Type',
                      heightToExpand: 150,
                      containerHeight: 100,
                      text: tribeDb.triberersType!,
                    ),
                    RoundedContainer(
                      height: oneLineContainerHeight,
                      lable: 'Tribe Type',
                      child: Text(
                        tribeDb.type!,
                        textAlign: TextAlign.center,
                        style: plainTextStyle,
                      ),
                    ),
                    RoundedExpandedContainer(
                      lable: 'Description',
                      heightToExpand: 200,
                      containerHeight: 150,
                      text: tribeDb.description!,
                    ),
                  ]
                : [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: AppColors.primaryColor,
                          child: CircleAvatar(
                            backgroundImage:
                                Image.asset(tribeDb.localTribalSign!).image,
                            radius: 30,
                            backgroundColor: AppColors.greyColor,
                          ),
                        ),
                        horizontalSpace15,
                        Stack(
                          children: [
                            Neumorphic(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              style: NeumorphicStyle(
                                shadowLightColorEmboss: AppColors.primaryColor,
                                depth: -5,
                                shape: NeumorphicShape.convex,
                                lightSource: LightSource.bottomRight,
                                intensity: 60,
                                color: AppColors.white,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20)),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                width: 0.6.sw,
                                height: 80,
                                alignment: Alignment.topLeft,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Name",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: AppColors.blackColor)),
                                      Text(
                                        //49 letters max
                                        'Lorem Ipsum has been the industrys standard dummy',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.blackColor,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
          );
        }));
  }
}

class GiveNameButton extends StatelessWidget {
  const GiveNameButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 10),
      style: NeumorphicStyle(
        shadowDarkColor: AppColors.blackColor,
        shadowLightColorEmboss: AppColors.primaryColor,
        depth: 3,
        shape: NeumorphicShape.convex,
        lightSource: LightSource.topLeft,
        intensity: 60,
        color: AppColors.white,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 25,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.actionColor),
        child: Text('Give Name', style: textSWhiteColorSmall),
      ),
    );
  }
}

class TribeProfileTabs extends StatelessWidget {
  const TribeProfileTabs(
      {Key? key,
      required this.currantSectionIndex,
      required this.switchSection})
      : super(key: key);

  final int currantSectionIndex;
  final Function(int) switchSection;

  @override
  Widget build(BuildContext context) {
    return FlutterToggleTab(
      selectedBackgroundColors: [AppColors.primaryColor],
      unSelectedBackgroundColors: [AppColors.white],
      width: 90.w,
      borderRadius: 25.r,
      selectedIndex: currantSectionIndex,
      selectedTextStyle: textSActionColorSmall,
      unSelectedTextStyle: textSBlackColorSmall,
      labels: const ['Triberers', 'Info'],
      selectedLabelIndex: switchSection,
      marginSelected: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    );
  }
}

class AvailableTimeRow extends StatelessWidget {
  const AvailableTimeRow({
    Key? key,
    required this.tribeDb,
  }) : super(key: key);

  final TribeDb? tribeDb;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          TimeCovertingServices.CountOffsetHour(
                  hour: tribeDb!.availableTime!.startZero,
                  offset: DateTime.now().timeZoneOffset.inHours)
              .toString(),
          style: tribalFontLableRed,
        ),
        Text(
          "-",
          style: tribalFontLableRed,
        ),
        Text(
          TimeCovertingServices.CountOffsetHour(
                  hour: tribeDb!.availableTime!.endZero,
                  offset: DateTime.now().timeZoneOffset.inHours)
              .toString(),
          style: tribalFontLableRed,
        ),
      ],
    );
  }
}
