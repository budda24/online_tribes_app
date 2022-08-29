//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/theme/alert_styles.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../controllers/profile_controller.dart';
import '../widgets/rounded_container.dart';
import '../widgets/rounded_expanded_container.dart';

class ProfileInfoView extends StatelessWidget {
  ProfileInfoView({Key? key}) : super(key: key);

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        profileController.videoController?.showAndHideOverlay(false);
      },
      child: GetBuilder<ProfileController>(builder: (getController) {
        return ProfileTemplate(
          profileImage: Image.network(getController.profilePhotoUrl),
          rigtTopPositionad:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Log Out',
              style: greenTitle,
            ),
            InkWell(
              onTap: () {
                /* profileController.logout(); */
                print(profileController.userDb!.availableTime!.timeZone);
              },
              child: Icon(
                Icons.logout,
                size: 50,
                color: AppColors.actionColor,
              ),
            ),
          ]),
          videoController: getController.videoController!,
          title: const SizedBox.shrink(),
          profileVideoSrc: getController.profileVideo,
          fields: [
            verticalSpaceSmall,
            Text(
              'Availability',
              style: tribalFontLable,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  profileController.userDb!.availableTime!.start.hours.inHours
                      .toString(),
                  style: tribalFontLableRed,
                ),
                Text(
                  "-",
                  style: tribalFontLableRed,
                ),
                Text(
                  profileController.userDb!.availableTime!.end.hours.inHours
                      .toString(),
                  style: tribalFontLableRed,
                ),
              ],
            ),
            RoundedExpandedContainer(
              lable: 'Life motto',
              heightToExpand: 100,
              containerHeight: 150,
              text: getController.lifeMottoController.text,
            ),
            RoundedExpandedContainer(
              lable: 'Description',
              heightToExpand: 200,
              containerHeight: 150,
              text: getController.describtionController.text,
            ),
            RoundedContainer(
              lable: 'Hobby',
              height: oneLineContainerHeight,
              child: Center(
                child: Text(
                  profileController.hobby1Controller.text,
                  style: plainTextStyle,
                ),
              ),
            ),
            RoundedContainer(
              lable: 'Hobby',
              height: oneLineContainerHeight,
              child: Center(
                child: Text(
                  profileController.hobby2Controller.text,
                  style: plainTextStyle,
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  Alerts.confirmation(
                          onConfirm: profileController.deleteUser,
                          title: "Are you Sure you want to delete",
                          content: "All you data will be deleted irreversibly ")
                      .showConfirmDialog();
                },
                child: TextContainerLable(
                  text: 'Delete Account',
                  lableStyle: tribalFontLableRed,
                ),),
          ],
        );
      }),
    );
  }
}
