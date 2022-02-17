// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_bars.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/rounded_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Package imports:

// Project imports:
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

class DescriotionExamplePage extends StatelessWidget {
  final String description;
  final String imageUrl;
  final String title;
  const DescriotionExamplePage({
    Key? key,
    required this.description,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackArrow(
        title: Text(
          'Destription Examples',
          style: headingBoldStyle,
        ),
      ),
      backgroundColor: kMainColor,
      body: LayoutBuilder(
        builder: (_, boxConstrains) => SafeArea(
          child: Column(
              /* mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, */
              children: [
                Row(children: [
                  Container(
                    width: 80.w,
                    height: 80.h,
                    margin: EdgeInsets.only(left: 20),
                    child: Image.network(imageUrl),
                  ),
                  Text(
                    title,
                    style: kName,
                  ),
                ]),
                verticalSpaceMedium,
                RoundedContainer(
                  height: 500.h,
                  /* width: , */
                  screanHeight: boxConstrains.maxHeight,
                  screanWidth: boxConstrains.maxWidth,
                  bcColor: AppColors.whiteColor,
                  child: SingleChildScrollView(
                    child: Text(
                      description,
                      style: longText,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
