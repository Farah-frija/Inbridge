import 'package:flutter/material.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';

class BackToPage extends StatelessWidget {
  BackToPage({required this.onpressed, required this.text, this.text2});
  Function() onpressed;
  String text;
  String? text2;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onpressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: kForgotpass),
            Text(text2 ?? '', style: kpage)
          ],
        ));
  }
}
