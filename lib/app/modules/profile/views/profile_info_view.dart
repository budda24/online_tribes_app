/* import 'package:chewie/chewie.dart'; */
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/rounded_container.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/rounded_expanded_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';

import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';

class ProfileInfoView extends StatelessWidget {
  ProfileInfoView({Key? key}) : super(key: key);

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    print('ProfileInfoView');
    const int oneLineContainerHeight = 60;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          profileController.videoController?.showAndHideOverlay(false);
        },
        child: GetBuilder<ProfileController>(builder: (getController) {
          return SingleChildScrollView(
            child: ProfileTemplate(
              profileImage: Image.network(getController.profilePhotoUrl),
              videoController: getController.videoController!,
              title: const SizedBox.shrink(),
              videoSrc: getController.profileVideo,
              fields: [
                verticalSpaceSmall,
                RoundedExpandedContainer(
                  heightToExpand: 100,
                  containerHeight: 150,
                  text: getController.lifeMottoController.text,
                ),
                RoundedExpandedContainer(
                  heightToExpand: 200,
                  containerHeight: 150,
                  text: getController.describtionController.text,
                ),
                RoundedContainer(
                  height: oneLineContainerHeight,
                  child: Center(
                    child: Text(
                      profileController.hobby1Controller.text,
                      style: plainTextStyle,
                    ),
                  ),
                ),
                RoundedContainer(
                  height: oneLineContainerHeight,
                  child: Center(
                    child: Text(
                      profileController.hobby2Controller.text,
                      style: plainTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
