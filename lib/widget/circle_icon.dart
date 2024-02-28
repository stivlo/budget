import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon(this.iconData, this.background, {super.key});

  final IconData iconData;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: background,
      child: Icon(
        iconData,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
