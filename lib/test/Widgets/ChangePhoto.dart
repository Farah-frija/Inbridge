import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbridge/test/Models/User.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/Icons/icons.dart';
import 'package:inbridge/test/Utils/Camera.dart';
import 'package:inbridge/test/Widgets/CircleAvatar.dart';
import 'package:inbridge/test/auth/AddUser/AddUserController.dart';

class ChangeCamera extends StatelessWidget {
  ChangeCamera({required this.onpressed, required this.imageFile});
  final ImagePicker _picker = ImagePicker();
  final File? imageFile;
  Function(File?) onpressed;
  Widget build(BuildContext context) {
    return Stack(children: [
      Avatar(
        takePic: () {
          print("hii");
          onpressed(imageFile);
        },
        image: true,
        photo: imageFile,
        radius: 60,
        border: true,
        color: KRoseFonce,
      ),
      Positioned(
          right: 5,
          bottom: 0,
          child: Avatar(
            takePic: () {
              onpressed(imageFile);
            },
            image: false,
            icon: kcameraIcon,
            border: false,
            color: KRoseFonce,
            radius: 15,
          )),
    ]);
  }
}
