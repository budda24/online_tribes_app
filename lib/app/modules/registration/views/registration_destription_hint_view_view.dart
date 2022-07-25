// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_bars.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/profile/rounded_bacgroud_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Package imports:

// Project imports:
import '../../../helpers/main_constants.dart';

class DescriptionExamplePage extends StatelessWidget {
  final String description;
  final String imageAssetPath;
  final String title;
  const DescriptionExamplePage({
    Key? key,
    required this.description,
    required this.imageAssetPath,
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, boxConstrains) => SafeArea(
            child: Column(children: [
              Row(children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  margin: const EdgeInsets.only(left: 20),
                  child: Image.asset(imageAssetPath),
                ),
                Text(
                  title,
                  style: kName,
                ),
              ]),
              verticalSpaceMedium,
              RoundedBacgroundContainer(
                height: 500.h,
                screanHeight: boxConstrains.maxHeight,
                screanWidth: boxConstrains.maxWidth,
                bcColor: AppColors.whiteColor,
                child: SingleChildScrollView(
                  child: Text(
                    description,
                    style: longTextStyle,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
