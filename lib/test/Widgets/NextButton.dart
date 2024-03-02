import 'package:flutter/material.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';
import 'package:inbridge/core/constant/Themes/paddings/Paddings.dart';

class NextButton extends StatelessWidget {
  NextButton({super.key, this.Onpressed, required this.text});

  Function()? Onpressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: KroseClair,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(KnextButtonRadius)),
        ),
        padding: kNextButtonPadding,
      ),
      onPressed: Onpressed,
      child: Text(text, style: kButtonTextStyle),
    );
  }
}
