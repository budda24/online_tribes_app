import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/general/main_constants.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/controllers/tribe_registration_controller.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/widgets/invite_user_tile.dart';
import 'package:get/get.dart';

import '../../../helpers/widgets/online_tribes/general/search_bar.dart';

class InviteNewTribeMember extends StatelessWidget {
  InviteNewTribeMember({Key? key}) : super(key: key);

  // var tribeRegistrationController = Get.find<TribeRegistrationController>();
  var tribeRegistrationController = Get.put(TribeRegistrationController());

  @override
  Widget build(BuildContext context) {
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
                    Image.asset('assets/images/tribe_registration/check.png'),
                  ],
                ),
                Text(
                  'Peacemakers',
                  style: headingBoldStyle,
                ),
                SearchBar(
                    hintText: 'search by number or email',
                    searchCalback: () {},
                    controller: tribeRegistrationController),
                SizedBox(
                  height: 530,
                  width: 400,
                  child: GetBuilder<TribeRegistrationController>(
                    builder: (builderController) {
                      return builderController.usersList.isEmpty
                          ? spinkit
                          : GridView.builder(
                              controller: builderController.scrollController,
                              physics: const ScrollPhysics(),
                              itemCount: tribeRegistrationController.isLoading
                                  ? tribeRegistrationController
                                          .currentItemLength.value +
                                      1
                                  : tribeRegistrationController
                                      .currentItemLength.value,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 180,
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 3,
                                      crossAxisSpacing: 30,
                                      mainAxisSpacing: 0),
                              itemBuilder: ((context, index) {
                                if (builderController.currentItemLength.value ==
                                    index) {
                                  return Center(child: spinkit);
                                }

                                return InviteUserTile(
                                  userImage: tribeRegistrationController
                                      .usersList[index]
                                      .profilePhoto!
                                      .downloadUrl,
                                  userMotto: tribeRegistrationController
                                      .usersList[index].lifeMotto!,
                                );
                              }),
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
