import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbridge/Sprints/auth/login/Controller/loginController.dart';
import 'package:inbridge/core/constant/Approutes.dart';

abstract class VerifyEmailController extends GetxController {
  verify();
}

class VerifyEmailControllerImp extends VerifyEmailController {
  late TextEditingController email;
  LoginControllerImp logincontroller = Get.find();

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
    email = TextEditingController(text: logincontroller.email.text);

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();

    super.dispose();
  }
}
