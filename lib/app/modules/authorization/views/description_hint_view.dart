/* import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';


import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

class DescriotionExamplePage extends StatelessWidget {
  const DescriotionExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screeanheight = MediaQuery.of(context).size.height;
    final double screeanwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainCirclePhoto(
                  /* imagePathL: '', */
                  imagePathN: '',
                  /*imagePathL:'assets/images/authorization_screen/tribel_signs/Sign Business Tribe-01.png',*/
                    screeanheight: screeanheight / 1.6,
                    screeanwidth: screeanwidth),


                Text(
                  'Cornelius',
                  style: lable,
                ),

              ]),
        ),
      ),
    );
  }
}
 */