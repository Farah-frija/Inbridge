import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inbridge/Sprints/auth/AddUser/data/datasources/AddUserApi.dart';
import 'package:inbridge/Sprints/auth/AddUser/data/datasources/RegisterData.dart';
import 'package:inbridge/Sprints/auth/AddUser/data/models/AddUserModel.dart';
import 'package:inbridge/Sprints/auth/Functions/validateInput.dart';

import 'package:inbridge/core/Utils/Camera.dart';

import 'package:inbridge/core/network/handlingData.dart';
import 'package:inbridge/core/network/networkHandler.dart';

class AddUseController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);
  Camera? cam;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phoneNumber;
  late TextEditingController cin;
  late TextEditingController name;
  late TextEditingController familyName;
  late TextEditingController userName;
  late TextEditingController adresse;
  RxString sexe = "homme".obs;
  RxBool visible = false.obs;
  RxBool validePhoto = false.obs;
  RxBool validDate = false.obs;
  RxBool validForm = false.obs;
  Rx<DateTime> dateOfBirth = DateTime(2002, 8, 25).obs;
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  AddUserData loginData = AddUserData(AddUserApi());

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    phoneNumber = TextEditingController();
    cin = TextEditingController();
    name = TextEditingController();
    familyName = TextEditingController();
    userName = TextEditingController();
    adresse = TextEditingController();
    cam = Camera(updateimage);
    validePhoto = false.obs;
    validDate = false.obs;
    validForm = false.obs;

    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    cin.dispose();
    name.dispose();
    familyName.dispose();
    userName.dispose();
    super.onClose();
  }

  void updateimage(File? image) {
    imageFile.value = image;
  }

  void updateSexe(String value) {
    sexe.value = value;
  }

  void updateDateOfBirth(DateTime value) {
    dateOfBirth.value = value;
  }

  void addUser() async {
    if (formstate.currentState!.validate()) {
      validForm.value = true;
      if (validPhoto(imageFile.value)) {
        validePhoto.value = true;
      }
      if (validePhoto.value) {
        statusRequest.value = StatusRequest.loading;

        AddUserModel addUserModel = AddUserModel(
          email: email.text.trim(),
          pseudo: userName.text.trim(),
          cin: int.parse(cin.text.trim()),
          sexe: sexe.value,
          adresse: adresse.text.trim(),
          numeroDeTel: int.parse(phoneNumber.text.trim()),
          dateDeNaissance: dateOfBirth.value,
          nom: familyName.text.trim(),
          prenom: name.text.trim(),
          photoDeProfile: imageFile.value!,
        );
        statusRequest.value = StatusRequest.loading;

        var response = await loginData.postdata(addUserModel);
        print("=============================== Controller  ");
        print(addUserModel.photoDeProfile == null);

        statusRequest.value = handlingData(response);
        String title = "Success";
        String errorMessage =
            "A verification email was sent to this content creator";
        if (statusRequest.value != StatusRequest.success) {
          title = "warning";

          switch (statusRequest.value) {
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
              errorMessage = "An error has occured";
          }
        }
        Get.defaultDialog(
          title: title,
          middleText: errorMessage,
          onConfirm: () {
            Get.back();
          },
        );
      }
    }
  }
}
