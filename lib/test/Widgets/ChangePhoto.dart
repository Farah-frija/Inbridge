import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbridge/test/Models/User.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/Icons/icons.dart';
import 'package:inbridge/test/Utils/Camera.dart';
import 'package:inbridge/test/Widgets/CircleAvatar.dart';

class ChangeCamera extends StatefulWidget {
  ChangeCamera({required this.user});
  User user;

  @override
  State<ChangeCamera> createState() => _ChangeCameraState();
}

class _ChangeCameraState extends State<ChangeCamera> {
  final ImagePicker _picker = ImagePicker();
  Camera camera = Camera();
  void updateImage(CroppedFile croppedFile) {
    setState(() {
      widget.user.photo = File(croppedFile.path);
    });
  }

  void initState() {
    super.initState();
    camera.setUpdateImageCallback(updateImage);
  }

  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onTap: () {
          camera.onpressed(context);
        },
        child: Avatar(
          image: true,
          photo: widget.user.photo,
          radius: 60,
          border: true,
          color: KRoseFonce,
        ),
      ),
      Positioned(
          right: 5,
          bottom: 0,
          child: Avatar(
            image: false,
            icon: kcameraIcon,
            border: false,
            color: KRoseFonce,
            radius: 15,
          )),
    ]);
  }
}
