import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';

const borderColor = KRoseFonce;

class Avatar extends StatefulWidget {
  Avatar({
    Key? key,
    this.icon,
    required this.image,
    this.photo,
    this.color,
    required this.radius,
    required this.border,
  }) : super(key: key);
  final IconData? icon;
  final bool image;
  final File? photo;
  final Color? color;
  final double radius;
  final bool border;

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  String defaultImage =
      "https://th.bing.com/th/id/OIP.jfO-lSCNvMeuSaU5VzYYvgHaE7?rs=1&pid=ImgDetMain";

  @override
  Widget build(BuildContext context) {
    final double borderWidth = widget.border ? 3 : 0;
    final BorderStyle borderstyle =
        widget.border ? BorderStyle.solid : BorderStyle.none;

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
        onTap: () {},
        child: CircleAvatar(
          radius: widget.radius,
          backgroundImage: _getProfileImage(),
          backgroundColor: widget.color,
          child: Icon(
            widget.icon,
            color: kwhite,
            size: 19,
          ),
        ),
      ),
    );
  }

  ImageProvider<Object>? _getProfileImage() {
    if (widget.image) {
      if (widget.photo == null) {
        return NetworkImage(defaultImage);
      } else {
        return FileImage(widget.photo!);
      }
    }
    return null;
  }
}
