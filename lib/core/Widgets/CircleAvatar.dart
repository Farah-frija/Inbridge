import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';

const borderColor = KRoseFonce;

class Avatar extends StatelessWidget {
  Avatar(
      {Key? key,
      this.icon,
      required this.image,
      this.photo,
      this.color,
      required this.radius,
      required this.border,
      this.stringImage,
      this.takePic})
      : super(key: key);
  final IconData? icon;
  final bool image;
  final File? photo;
  final Color? color;
  final double radius;
  final bool border;
  final Function()? takePic;
  final String? stringImage;
  String? defaultImage;
  @override
  Widget build(BuildContext context) {
    if (stringImage == null)
      defaultImage =
          "https://th.bing.com/th/id/OIP.jfO-lSCNvMeuSaU5VzYYvgHaE7?rs=1&pid=ImgDetMain";
    else
      defaultImage = stringImage!;
    final double borderWidth = border ? 3 : 0;
    final BorderStyle borderstyle =
        border ? BorderStyle.solid : BorderStyle.none;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
          style: borderstyle,
        ),
      ),
      child: GestureDetector(
        onTap: takePic,
        child: CircleAvatar(
          radius: radius,
          backgroundImage: _getProfileImage(),
          backgroundColor: color,
          child: Icon(
            icon,
            color: kwhite,
            size: 19,
          ),
        ),
      ),
    );
  }

  ImageProvider<Object>? _getProfileImage() {
    if (image) {
      if (photo == null) {
        return NetworkImage(
          defaultImage!,
          scale: 1.0,
        );
      } else {
        return FileImage(photo!);
      }
    }
    return null;
  }
}
