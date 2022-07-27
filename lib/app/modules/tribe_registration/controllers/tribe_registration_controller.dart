import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/widgets/tribal_sign_picker.dart';
import 'package:get/get.dart';

import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
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

  List<Widget> tribesSigns = [
    TribeSignWithPointer(imagePath: cMotheringTribeSign, index: 0),
    TribeSignWithPointer(imagePath: cMusicalTribeSign, index: 1),
    TribeSignWithPointer(imagePath: cTravellerTribeSign, index: 2),
    TribeSignWithPointer(imagePath: cArtistTribeSign, index: 3),
    TribeSignWithPointer(imagePath: cBussinessTribeSign, index: 4),
    TribeSignWithPointer(imagePath: cWriteringTribeSign, index: 5),
    TribeSignWithPointer(imagePath: cIllnessTribeSign, index: 6),
    TribalSignPicker()
  ];
}
