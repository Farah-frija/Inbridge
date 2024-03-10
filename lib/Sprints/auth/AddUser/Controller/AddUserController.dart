// image_controller.dart

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inbridge/Sprints/auth/AddUser/data/datasources/AddUserApi.dart';
import 'package:inbridge/Sprints/auth/AddUser/data/datasources/RegisterData.dart';
import 'package:inbridge/Sprints/auth/AddUser/data/models/AddUserModel.dart';

import 'package:inbridge/core/Utils/Camera.dart';

import 'package:inbridge/core/network/handlingData.dart';
import 'package:inbridge/core/network/networkHandler.dart';

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
  late TextEditingController adresse;
  late String sexe;
  late bool visible;
  late bool validePhoto;
  late bool validDate;
  late bool validForm;
  late DateTime dateOfBirth;
  late StatusRequest statusRequest = StatusRequest.none;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  AddUserData loginData = AddUserData(AddUserApi());
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
    adresse = TextEditingController();
    sexe = "homme";
    validForm = false;
    dateOfBirth = DateTime(2002, 8, 25);
    bool validePhoto = false;
    bool valideDate = false;
    cam = Camera(updateimage);

    super.onInit();
  }

  void dispose() {
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    cin.dispose();
    name.dispose();
    familyName.dispose();
    userName.dispose();

    super.dispose();
  }

  void updateimage(File? image) {
    imageFile = image;
    update();
  }

  void updateSexe(String value) {
    sexe = value;
    update();
  }

  void updateDateOfBith(DateTime value) {
    dateOfBirth = value;
    update();
  }

  AddUser() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      AddUserModel addUserModel = AddUserModel(
        email: email.value.text.trim(),
        pseudo: userName.text.trim(),
        cin: int.parse(cin.text.trim()),
        sexe: sexe,
        adresse: adresse.text.trim(),
        numeroDeTel: int.parse(phoneNumber.value.text.trim()),
        dateDeNaissance: dateOfBirth,
        nom: familyName.text.trim(),
        prenom: name.text.trim(),
      );
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postdata(addUserModel);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      update();
      if (statusRequest == StatusRequest.success) {
      } else {
        String errorMessage = "";
        switch (statusRequest) {
          case StatusRequest.existent:
            errorMessage = "existent user";
            break;

          case StatusRequest.notFound:
            errorMessage = "this email doesn't exist";
            break;
          case StatusRequest.invalidinfo:
            errorMessage = "wrong entries";
            break;

          default:
            if (StatusRequest.serverFailure == statusRequest) {
              errorMessage = "An error has occured";
            }
        }

        Get.defaultDialog(
          title: "Warning",
          middleText: errorMessage,
          onConfirm: () {
            Get.back();
          },
        );
      }
    }
  }
}
