import 'package:flutter/material.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';

class LoginButton extends StatelessWidget {
  LoginButton({required this.text, this.onpressed});
  String text;
  Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(KroseClair),
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          )),
      child: Text(
        text,
        style: kButtonTextStyle,
      ),
    );
  }
}
