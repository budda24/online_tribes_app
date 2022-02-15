import 'package:flutter/material.dart';

class MainCirclePhoto extends StatelessWidget {
   MainCirclePhoto(
      {required this.screeanwidth,
      required this.imagePathN,
      /* required this.imagePathL, */
      required this.screeanheight});

  const MainCirclePhoto.networking({
    required this.screeanheight,
    required this.screeanwidth,
    required this.imagePathN
  })/* :imagePathL='' */;

  /* const MainCirclePhoto.local({
    required this.screeanheight,
    required this.screeanwidth,
    required this.imagePathL,


  }):imagePathN=''; */

  final double screeanheight;
  final double screeanwidth;
  final String imagePathN;
  /* final String imagePathL; */
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: screeanheight * 0.03, bottom: screeanheight * 0.0),
      width: screeanwidth * 0.4,
      height: screeanheight * 0.2,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5.0,
          color: Color(0xffF4F9FD),
        ),
        shape: BoxShape.circle,
        image:
            DecorationImage(image: NetworkImage(imagePathN), /* fit: BoxFit.fill */),
      ),
    );
  }
}
