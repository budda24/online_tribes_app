import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/main_constants.dart';
import '../models/tribal_example.dart';
import '../views/registration_destription_hint_view_view.dart';



class TribeExamplesDialog extends StatelessWidget {
  const TribeExamplesDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
        height: 445.h,
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: ListView.builder(
            itemCount: TribeProfileExamples
                .listTribeProfileExamples.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(
                    bottom: 10.h, top: 10.h),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          DescriptionExamplePage(
                            description: TribeProfileExamples
                                .listTribeProfileExamples[
                                    index]
                                .description,
                            title: TribeProfileExamples
                                .listTribeProfileExamples[
                                    index]
                                .tribeName,
                            imageAssetPath:
                                TribeProfileExamples
                                    .listTribeProfileExamples[
                                        index]
                                    .imageAssetPath,
                          ),
                        );
                      },
                      child: Container(
                        width: 80.w,
                        height: 80.h,
                        margin:
                            const EdgeInsets.only(left: 20),
                        child: Image.asset(
                            TribeProfileExamples
                                .listTribeProfileExamples[
                                    index]
                                .imageAssetPath),
                      ),
                    ),
                    SizedBox(
                      width: 38.w,
                    ),
                    Column(children: [
                      Text(
                        TribeProfileExamples
                            .listTribeProfileExamples[index]
                            .userName,
                        style: kMontserratBold,
                      ),
                      Text(
                        TribeProfileExamples
                            .listTribeProfileExamples[index]
                            .tribeName,
                        style: kMontserratBold,
                      ),
                    ])
                  ],
                ),
              );
            }),
      ),
    );
  }
}

