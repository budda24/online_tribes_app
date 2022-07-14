import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// ignore: must_be_immutable
class NeumorphicCircleBackground extends StatelessWidget {
  Widget child;

  NeumorphicCircleBackground(
      {required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        style: const NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.circle(),
            depth: -10,
            intensity: 60,
            lightSource: LightSource.bottomRight,
            color: Colors.white),
        child: child);
  }
}
