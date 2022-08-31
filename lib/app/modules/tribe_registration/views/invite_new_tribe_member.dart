import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/controllers/tribe_registration_controller.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/widgets/invite_user_tile.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/widgets/online_tribes/general/search_bar.dart';

class InviteNewTribeMember extends StatelessWidget {
  InviteNewTribeMember({Key? key}) : super(key: key);

  // var tribeRegistrationController = Get.find<TribeRegistrationController>();
  var tribeRegistrationController = Get.put(TribeRegistrationController());

  @override
  Widget build(BuildContext context) {
    print('rebuild>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.actionColor,
                    ),
                    SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.asset(cBussinessTribeSign)),
                    GetBuilder<TribeRegistrationController>(
                      builder: (builderController) {
                        return Neumorphic(
                          style: const NeumorphicStyle(
                            depth: -10,
                            intensity: 20,
                            oppositeShadowLightSource: true,
                          ),
                          child: InkWell(
                            onTap: () async {
                              await builderController.showAllUsersAgain();
                             await builderController.sendInviteNotyficationToUsers();
                            },
                            child: Container(
                              width: 70.h,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color:
                                    builderController.temporaryUsersList.isEmpty
                                        ? AppColors.primaryColor
                                        : AppColors.actionColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppColors.greyColor, width: 1),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: Image.asset(
                                        'assets/images/profile/tent-tablet.png'),
                                  ),
                                  const Center(
                                      child: Text(
                                    'show all users again',
                                    textAlign: TextAlign.center,
                                  ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  'Peacemakers',
                  style: headingBoldStyle,
                ),
                SearchBar(
                    textEditingController:
                        tribeRegistrationController.searchTextEditingController,
                    hintText: 'search by number or email',
                    searchCalback: () async {
                      await tribeRegistrationController.searchByEmailOrPhone();
                    },
                    controller: tribeRegistrationController),
                SizedBox(
                  height: 530,
                  width: 400,
                  child: GetBuilder<TribeRegistrationController>(
                    builder: (builderController) {
                      return builderController.usersList.isEmpty
                          ? spinkit
                          : GridView(
                              controller: builderController.scrollController,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 180,
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 3,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 0),
                              children: [
                                ...builderController.usersList
                                    .map((e) => InviteUserTile(user: e))
                                    .toList(),
                                if (builderController.hasMore &&
                                    builderController
                                        .temporaryUsersList.isEmpty)
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        builderController.fetchNextUsers();
                                      },
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: spinkit,
                                      ),
                                    ),
                                  )
                              ],
                            );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
