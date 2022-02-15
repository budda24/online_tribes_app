import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_bars.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../helpers/assets/networkIng_images.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

class RegistrationUploadVideoView extends StatelessWidget {
  final controllerRegistration = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(411, 809),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      backgroundColor: kMainColor,
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          /* alignment: Alignment.center, */
          children: [
            Positioned(
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  child: Form(
                    child: Column(
                      children: [
                        /* TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Type in your text",
                              fillColor: Colors.white70),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Type in your text",
                              fillColor: Colors.white70),
                        ), */
                        TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.blue,
                            hintText: 'Enter a product name eg. pension',
                            hintStyle: TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                        /*  CustomFormField(
                          lenght: 10,
                          displayedText: 'Tribal Name',
                          controler:
                              controllerRegistration.tribalNameController,
                          saved: () {},
                        ),
                        CustomFormField(
                          lenght: 10,
                          displayedText: 'Tribal Name',
                          controler:
                              controllerRegistration.tribalNameController,
                          saved: () {},
                        ), */
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: AppColors.whiteColor,
                  ),
                  width: 411.w,
                  height: 680.h,
                ),
              ),
            ),
            Positioned.fill(
              /* top: -10, */
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(children: [
                  Text(
                    'Sign Up',
                    style: headingBoldStyle,
                  ),
                  MainCirclePhoto.networking(
                      /* imagePathL: '', */
                      imagePathN:
                          'https://dsm01pap004files.storage.live.com/y4m_NLYDjl1WsO0m3Cc0jMZWBlY2GWMN0WSGoBjemVm6bZGdnJhsNEE-ece4G0QPUyH65WapVziK2Nhfzu8VinUIqVGqoqKFCpMjyip8CgmQS5SZz-Mzq5cvAnQpIkgKeWAOztb9rapynbJpm7sTzM66euz784RbPFVyl5NraciSiy6qGxXYJrHybz3YT8gY2aN?width=57&height=57&cropmode=none',
                      screeanheight: 300.h,
                      screeanwidth: 250.w),
                ]),
              ),
            ),
            Positioned.fill(
              top: 10,
              left: 30,
              child: Align(
                alignment: Alignment.topCenter,
                child: IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    color: AppColors.greyColor,
                  ),
                  //add profile photo
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
