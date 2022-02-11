import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/row_progress_dott.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/* import 'package:flutter_application_1/app/helpers/main_constants.dart'; */
import '../../../helpers/widgets/core/app_texts.dart';
import '../../../helpers/widgets/online_tribes/main_button.dart';
import '../controllers/walkthrough_controller.dart';
import '../../../helpers/widgets/online_tribes/bacground_waves_thene.dart';

class WalkthroughView extends GetView<WalkthroughController> {
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
      body: SafeArea(
        child: Center(
          child: Obx(
            () => controller.onBoardingList.isEmpty
                ? Container()
                : NotificationListener<ScrollNotification>(
                    onNotification: controller.onScroll,
                    child: PageView.builder(
                      itemCount: controller.onBoardingList.length,
                      physics: const ScrollPhysics(),
                      controller: controller.pageController,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 398.h,
                              child: Stack(
                                children: [
                                  GreenWaves1(
                                    screeanheight: 809.h,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 56.h),
                                    child: Center(
                                      child: Image.asset(
                                        controller
                                                .onBoardingList[index].imageName ??
                                            '',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                           verticalSpaceExtraLarge,
                            Center(
                              child: Container(
                                height: 68.h,
                                  child: HeadingTextLabel(
                                controller.onBoardingList[index].title ?? '',
                              )),
                            ),
                            verticalSpaceExtraLarge,
                            Center(
                                child: /* TextButton(
                              child: Text('Next'),
                              onPressed: controller.onTap,
                            ) */
                                SlimRoundedButton(
                                onPress: controller.onTap,
                                title: 'Continue',
                                backgroundColour: AppColors.blueColor,
                                textColor: AppColors.whiteColor,
                              ),
                                ),

                            /* Center(
                                child: RowProgressDots(
                                  screeanheight:801.h ,
                                  screeanwidth: 411.w,
                                  dott1: AppColors.primaryColor,
                                  dott2: AppColors.primaryColorWithOpacity40,
                                  dott3: AppColors.primaryColorWithOpacity40,
                                ),
                              ), */
                          ],
                        );
                      },
                    ),
                  ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('Skip'),
              onPressed: controller.onSkipPressed,
            ),

          ],
        ),
      ),
    );
  }
}
