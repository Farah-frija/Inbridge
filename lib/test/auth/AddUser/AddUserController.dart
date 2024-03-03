// image_controller.dart

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inbridge/core/Functions/ImageService.dart';
import 'package:inbridge/test/Utils/Camera.dart';

class AddUseController extends GetxController {
  File? imageFile;
  Camera? cam;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phoneNumber;
  late TextEditingController cin;
  late TextEditingController name;
  late TextEditingController familyName;
  late TextEditingController userName;
  late TextEditingController institute;
  late TextEditingController sexe;
  late TextEditingController diplome;

  late bool visible;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  void onInit() {
    visible = false;
    email = TextEditingController();
    password = TextEditingController();
    phoneNumber = TextEditingController();
    cin = TextEditingController();
    name = TextEditingController();
    familyName = TextEditingController();
    userName = TextEditingController();
    institute = TextEditingController();
    sexe = TextEditingController();
    diplome = TextEditingController();

    cam = Camera(updateimage);
    super.onInit();
  }

  void updateimage(File? image) {
    imageFile = image;
    update();
  }
}
