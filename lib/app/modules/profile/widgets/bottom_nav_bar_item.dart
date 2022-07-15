import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  String title;
  String imagePath;
  VoidCallback onTap;

  BottomNavBarItem({
    required this.title,
    required this.imagePath,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 35,
              width: 35,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset(imagePath),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
