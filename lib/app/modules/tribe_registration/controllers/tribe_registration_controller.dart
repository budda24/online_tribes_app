// Package imports:

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/user_db_services.dart';
import 'package:flutter_application_1/infrastructure/fb_services/models/user_model.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/widgets/online_tribes/general/main_constants.dart';

class TribeRegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descritionController = TextEditingController();
  TextEditingController purpouseController = TextEditingController();
  TextEditingController goalsController = TextEditingController();
  TextEditingController mottoOfTribeController = TextEditingController();
  TextEditingController weeklySuggestedTimeController = TextEditingController();

  RxInt? choosenSignIndex = (-1).obs;
  RxBool isSignChosen = false.obs;
  String? chosenTribalSign;
  File? uploadedTribalSign;

  List<Map<String, dynamic>> tribesSigns = [
    {'imagePath': cMotheringTribeSign, 'index': 0},
    {'imagePath': cMusicalTribeSign, 'index': 1},
    {'imagePath': cTravellerTribeSign, 'index': 2},
    {'imagePath': cArtistTribeSign, 'index': 3},
    {'imagePath': cBussinessTribeSign, 'index': 4},
    {'imagePath': cWriteringTribeSign, 'index': 5},
    {'imagePath': cIllnessTribeSign, 'index': 6},
    /* TribeSignWithPointer(imagePath: cMotheringTribeSign, index: 0),
    TribeSignWithPointer(imagePath: cMusicalTribeSign, index: 1),
    TribeSignWithPointer(imagePath: cTravellerTribeSign, index: 2),
    TribeSignWithPointer(imagePath: cArtistTribeSign, index: 3),
    TribeSignWithPointer(imagePath: cBussinessTribeSign, index: 4),
    TribeSignWithPointer(imagePath: cWriteringTribeSign, index: 5),
    TribeSignWithPointer(imagePath: cIllnessTribeSign, index: 6),
    TribalSignPicker() */
  ];

/////////////////////////
  ///
  ///
  List<UserDB> usersList = [];
  final ScrollController scrollController = ScrollController();
  RxInt itemLimit = 6.obs;
  RxInt currentItemLength = 0.obs;
  RxInt previousItemLength = 0.obs;
  bool isLoading = false;

  Future<void> getUsers() async {
    usersList = await Future.delayed(const Duration(seconds: 3)).then(
      (_) {
        return UserDBServices().feachAllUsers(limit: itemLimit.value);
      },
    );

    currentItemLength.value = usersList.length;
    isLoading = false;
    update();
    print('object>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  }

  void scrollListener() {
    final position = scrollController.offset;

    if (position >= 0.8) {
      //  if (previousItemLength != currentItemLength) {
      // previousItemLength = currentItemLength;
      itemLimit = itemLimit + 2;
      isLoading = true;
      update();
      getUsers();
      print(' added >>>>>>>>>>>');
      //  }
    }
  }

  rebuildWidget() {
    update();
  }

  @override
  void onInit() async {
    scrollController.addListener(scrollListener);
    print('init');

    await getUsers();

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }
}
