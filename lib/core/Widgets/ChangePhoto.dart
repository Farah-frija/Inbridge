import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbridge/Sprints/auth/AddUser/Controller/AddUserController.dart';
import 'package:inbridge/test/Models/User.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/Icons/icons.dart';
import 'package:inbridge/core/Utils/Camera.dart';
import 'package:inbridge/core/Widgets/CircleAvatar.dart';

class ChangeCamera extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Widget build(BuildContext context) {
    AddUseController controller = Get.put(AddUseController());
    return InkWell(
      onTap: () {
        print("tapped");
        controller.cam!.onpressed(context);
      },
      child: SizedBox(
        child: Stack(children: [
          Avatar(
            image: true,
            photo: controller.imageFile,
            radius: MediaQuery.of(context).size.width * 0.2 > 80
                ? MediaQuery.of(context).size.width * 0.1
                : MediaQuery.of(context).size.width * 0.18,
            border: true,
            color: KRoseFonce,
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
        ]),
      ),
    );
  }
}
