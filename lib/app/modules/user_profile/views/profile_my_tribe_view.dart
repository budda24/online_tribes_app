//Package imports:
import 'package:flutter_application_1/app/modules/tribe_registration/views/invite_new_tribe_member.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/widgets/online_tribes/general/search_bar.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../../../helpers/widgets/online_tribes/profile/tribal_tile.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileMyTribeView extends StatelessWidget {
  var profileController = Get.find<ProfileController>();

  ProfileMyTribeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileTemplate(
      rigtTopIconColumn:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          'Create a Tribe',
          style: greenTitle,
        ),
        InkWell(
          onTap: () {
            Get.toNamed(Routes.TRIBE_REGISTRATION);
            //Get.to(InviteNewTribeMember());
          },
          child: Image.asset('assets/images/profile/create-tribe.png'),
        ),
      ]),
      fields: [
        SearchBar(
            textEditingController: profileController.searchController,
            hintText: 'search',
            searchCalback: () {},
            controller: profileController),
        TribeTile(
          tribalSign: Image.asset(cMotheringTribeSign),
          tribalName: 'Mothering',
          letterCallback: () {},
        ),
        TribeTile(
          letterCallback: () {},
          tribalName: 'Travelers',
          tribalSign: Image.asset(cTravellerTribeSign),
        ),
        TribeTile(
          letterCallback: () {},
          tribalName: 'Pacemakers',
          tribalSign: Image.asset(cBussinessTribeSign),
        ),
        TribeTile(
          letterCallback: () {},
          tribalName: 'Pacemakers',
          tribalSign: Image.asset(cBussinessTribeSign),
        ),
        TribeTile(
          letterCallback: () {},
          tribalName: 'Pacemakers',
          tribalSign: Image.asset(cBussinessTribeSign),
        ),
        TribeTile(
          letterCallback: () {},
          tribalName: 'Pacemakers',
          tribalSign: Image.asset(cBussinessTribeSign),
        ),
      ],
      title: const SizedBox.shrink(),

      profileImage: Image.network(profileController.userDB!.profilePhotoRef!.downloadUrl),
    );
  }
}
