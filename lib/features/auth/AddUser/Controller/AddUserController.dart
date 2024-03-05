// image_controller.dart

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inbridge/core/Utils/Camera.dart';
import 'package:inbridge/features/auth/Functions/validateInput.dart';

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
  late TextEditingController dateOfBirth;
  late bool visible;
  late bool valide;
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
    dateOfBirth = TextEditingController();

    cam = Camera(updateimage);
    super.onInit();
  }

  AddUser() {
    var formdata = formstate.currentState;
    if (validPhoto(imageFile)) {
      valide = true;
    } else if (formdata!.validate() && !validPhoto(imageFile)) {}
  }

  void dispose() {
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    cin.dispose();
    name.dispose();
    familyName.dispose();
    userName.dispose();
    institute.dispose();
    sexe.dispose();
    diplome.dispose();
    dateOfBirth.dispose();
    super.dispose();
    valide = false;
  }

  void updateimage(File? image) {
    imageFile = image;
    update();
  }
}
