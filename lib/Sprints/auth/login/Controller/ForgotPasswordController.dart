import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbridge/core/constant/Approutes.dart';

abstract class PasswordController extends GetxController {
  verify();
}

class PasswordControllerImp extends PasswordController {
  late TextEditingController email;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  void GoToLogin() {
    Get.offAllNamed(AppRoute.login);
  }

  @override
  verify() {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      //Get.offAllNamed(AppRoute.SuccessPassword);
    } else {
      print("Not Valid");
    }
  }

  @override
  void onInit() {
    email = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();

    super.dispose();
  }
}
