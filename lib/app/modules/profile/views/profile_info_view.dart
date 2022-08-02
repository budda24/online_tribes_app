//Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../controllers/profile_controller.dart';
import '../widgets/rounded_container.dart';
import '../widgets/rounded_expanded_container.dart';

class ProfileInfoView extends StatelessWidget {
  ProfileInfoView({Key? key}) : super(key: key);

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    print('ProfileInfoView');

    return GestureDetector(
      onTap: () {
        profileController.videoController?.showAndHideOverlay(false);
      },
      child: GestureDetector(
        onTap: () {
          profileController.videoController?.showAndHideOverlay(false);
        },
        child: GetBuilder<ProfileController>(builder: (getController) {
          return ProfileTemplate(
            profileImage: Image.network(getController.profilePhotoUrl),
            videoController: getController.videoController!,
            title: const SizedBox.shrink(),
            profileVideoSrc: getController.profileVideo,
            fields: [
              verticalSpaceSmall,
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
            ],
          );
        }),
      ),
    );
  }
}
