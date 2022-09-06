import 'package:flutter_application_1/app/controllers/camera_controller.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/controllers/tribe_registration_controller.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/widgets/invite_user_tile.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/widgets/online_tribes/general/main_button.dart';
import '../../../helpers/widgets/online_tribes/general/search_bar.dart';

class InviteTribeMember extends StatelessWidget {
  InviteTribeMember({Key? key}) : super(key: key);

  // var tribeRegistrationController = Get.find<TribeRegistrationController>();
  var tribeRegistrationController = Get.put(TribeRegistrationController());
  var cameraController = Get.find<CameraController>();
  var globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    tribeRegistrationController.limit = 5;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfilePhotoWithName(
                        localTribalSign:
                            tribeRegistrationController.tribeDB.localTribalSign,
                        name: tribeRegistrationController.tribeDB.tribalName,
                        cameraController: cameraController),
                  ],
                ),
                verticalSpaceMedium,
                SearchBar(
                  textEditingController:
                      tribeRegistrationController.searchTextEditingController,
                  hintText: 'search by number or email',
                  searchCalback: () async {
                    /* await tribeRegistrationController.searchByEmailOrPhone(); */
                  },
                ),
                GetBuilder<TribeRegistrationController>(
                  builder: (builderController) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      height: builderController.isMaxInvitation() ? 440 : 530,
                      width: 400,
                      child: builderController.displayedUsersList.isEmpty
                          ? spinkit
                          : InviteTriberersGrid(
                              scrollController:
                                  builderController.scrollController,
                              gridTilesList: [
                                ...builderController.displayedUsersList
                                    .map((e) => InviteUserTile(user: e))
                                    .toList(),
                                builderController.moreUserExist
                                    ? Center(
                                        child: SizedBox(
                                          height: 50.h,
                                          width: 50.w,
                                          child: spinkit,
                                        ),
                                      )
                                    : const RowInfoTextContainer(
                                        text: 'No More Users',
                                      )
                              ],
                            ),
                    );
                  },
                ),
                GetBuilder<TribeRegistrationController>(
                    builder: (builderController) {
                  return builderController.isMaxInvitation()
                      ? SlimRoundedButton(
                          onPress: () async {
                            var succeedeInvitation = await builderController
                                .sendInviteNotyficationToUsers();
                            if (succeedeInvitation ==
                                builderController.maxInvitation) {
                              //TODO go to home screen
                            } else {
                              globalController
                                  .showErrror('not succeeded to send any user');
                            }
                          },
                          backgroundColour: kColorWhite,
                          title: 'Continue',
                          textColor: kTextColorDarkGrey,
                        )
                      : const SizedBox.shrink();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowInfoTextContainer extends StatelessWidget {
  const RowInfoTextContainer({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 10),
      style: NeumorphicStyle(
        color: AppColors.errorRedColor,
        shadowLightColorEmboss: AppColors.white,
        depth: -4,
        intensity: 5,
        oppositeShadowLightSource: true,
        shape: NeumorphicShape.convex,
        lightSource: LightSource.topLeft,
        border: NeumorphicBorder(width: 2, color: AppColors.primaryColor),
        shadowDarkColor: AppColors.darkGreyColor,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
      ),
      child: SizedBox(
        width: 0.8.sw,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: headingBlackStyle,
          ),
        ),
      ),
    );
  }
}

class InviteTriberersGrid extends StatelessWidget {
  const InviteTriberersGrid({
    required this.gridTilesList,
    required this.scrollController,
    Key? key,
  }) : super(key: key);
  final List<Widget> gridTilesList;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return GridView(
        controller: scrollController,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 205,
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 0),
        children: gridTilesList);
  }
}

class ProfilePhotoWithName extends StatelessWidget {
  const ProfilePhotoWithName({
    Key? key,
    required this.localTribalSign,
    required this.cameraController,
    this.name,
  }) : super(key: key);

  final String? localTribalSign;
  final String? name;
  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          //TODO CHANGE TO ==
          backgroundImage: localTribalSign == null
              ? Image.file(cameraController.pickedPhoto!).image
              //TODO CHANGE TO the controller trial sign
              : Image.asset(localTribalSign!).image,
          radius: 65,
          backgroundColor: AppColors.greyColor,
        ),
        name == null
            ? const SizedBox.shrink()
            : Text(
                name!,
                style: headingBoldStyle,
              ),
      ],
    );
  }
}
