//Package imports:
import 'package:flutter_application_1/app/modules/tribe_registration/views/invite_new_tribe_member.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/widgets/online_tribes/general/search_bar.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../../../helpers/widgets/online_tribes/profile/tribal_tile.dart';
import '../controllers/profile_controller.dart';

class ProfileMyTribeView extends StatelessWidget {
  var profileController = Get.find<ProfileController>();

  ProfileMyTribeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileTemplate(
      rigtTopPositioned:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          'Create a Tribe',
          style: greenTitle,
        ),
        InkWell(
          onTap: () {
            // Get.toNamed(Routes.TRIBE_REGISTRATION);
            Get.to(InviteNewTribeMember());
          },
          child: Image.asset('assets/images/profile/create-tribe.png'),
        ),
      ]),
      videoController: null,
      fields: [
        SearchBar(
            textEditingController: profileController.searchController,
            hintText: 'search',
            searchCalback: () {},
            controller: profileController),
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
        TribeTile(
          letterCallback: () {},
          tribalName: 'Pacemakers',
          tribalSign: Image.asset(
              'assets/images/authorization_screen/tribel_signs/business_tribe.png'),
        ),
        TribeTile(
          letterCallback: () {},
          tribalName: 'Pacemakers',
          tribalSign: Image.asset(
              'assets/images/authorization_screen/tribel_signs/business_tribe.png'),
        ),
        TribeTile(
          letterCallback: () {},
          tribalName: 'Pacemakers',
          tribalSign: Image.asset(
              'assets/images/authorization_screen/tribel_signs/business_tribe.png'),
        ),
      ],
      title: const SizedBox.shrink(),
      profileVideoSrc: '',
      profileImage: Image.network(profileController.profilePhotoUrl),
    );
  }
}
