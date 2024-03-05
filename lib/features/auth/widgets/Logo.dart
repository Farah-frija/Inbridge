import 'package:flutter/material.dart';
import 'package:inbridge/core/constant/images/imagesurls.dart';

class Logo extends StatelessWidget {
  const Logo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      klogo,
      width: 300.0,
      height: 250.0,
    );
  }
}
