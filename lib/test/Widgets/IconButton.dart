import 'package:flutter/material.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/paddings/Paddings.dart';

class SmallButton extends StatelessWidget {
  SmallButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.radius,
      required this.padding});
  Color color;
  IconData icon;
  double radius;
  double padding;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: null,
      icon: Icon(
        icon,
        color: kwhite,
        weight: 5,
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)))),
    );
  }
}
