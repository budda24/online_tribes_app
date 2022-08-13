// Package imports:
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
import '../widgets/tribal_sign_picker.dart';
import '../widgets/tribe_sign_with_pointer.dart';

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
  String? uploadedTribalSign;

  List<Map<String,dynamic>> tribesSigns = [
    {'imagePath': cMotheringTribeSign, 'index':0 },
    {'imagePath': cMusicalTribeSign, 'index':1 },
    {'imagePath': cTravellerTribeSign, 'index':2 },
    {'imagePath': cArtistTribeSign, 'index':3 },
    {'imagePath': cBussinessTribeSign, 'index':4 },
    {'imagePath': cWriteringTribeSign, 'index':5 },
    {'imagePath': cIllnessTribeSign, 'index':6 },
    /* TribeSignWithPointer(imagePath: cMotheringTribeSign, index: 0),
    TribeSignWithPointer(imagePath: cMusicalTribeSign, index: 1),
    TribeSignWithPointer(imagePath: cTravellerTribeSign, index: 2),
    TribeSignWithPointer(imagePath: cArtistTribeSign, index: 3),
    TribeSignWithPointer(imagePath: cBussinessTribeSign, index: 4),
    TribeSignWithPointer(imagePath: cWriteringTribeSign, index: 5),
    TribeSignWithPointer(imagePath: cIllnessTribeSign, index: 6),
    TribalSignPicker() */
  ];
}
