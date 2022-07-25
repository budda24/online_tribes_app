import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/rounded_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../helpers/main_constants.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/widgets/online_tribes/general/search_bar.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../../../helpers/widgets/online_tribes/profile/tribal_tile.dart';

class ProfileMyTribeView extends StatelessWidget {
  var profileController = Get.find<ProfileController>();

  ProfileMyTribeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ProfileMyTribeView');
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfileTemplate(
              videoController: null,
              fields: [
                SearchBar(searchCalback: () {}, controller: profileController),
                TribeTile(
                  tribalSign: Image.asset(
                      'assets/images/authorization_screen/tribel_signs/mothering_tribe.png'),
                  tribalName: 'Mothering',
                  letterCallback: () {},
                ),
                TribeTile(
                  letterCallback: () {},
                  tribalName: 'Travelers',
                  tribalSign: Image.asset(
                      'assets/images/authorization_screen/tribel_signs/traveller_tribe.png'),
                ),
                TribeTile(
                  letterCallback: () {},
                  tribalName: 'Pacemakers',
                  tribalSign: Image.asset(
                      'assets/images/authorization_screen/tribel_signs/business_tribe.png'),
                ),
              ],
              title: const SizedBox.shrink(),
              videoSrc: '',
              profileImage: Image.network(profileController.profilePhotoUrl),
            ),
            verticalSpaceTiny,
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }
}




