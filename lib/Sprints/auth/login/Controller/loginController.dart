import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:inbridge/Sprints/auth/login/data/datasources/LoginData.dart';
import 'package:inbridge/Sprints/auth/login/data/datasources/loginApi.dart';
import 'package:inbridge/Sprints/auth/login/data/models/loginModel.dart';
import 'package:inbridge/core/constant/Approutes.dart';
import 'package:inbridge/core/network/handlingData.dart';
import 'package:inbridge/core/network/networkHandler.dart';
import 'package:inbridge/core/services/services.dart';

abstract class LoginController extends GetxController {
  login();
  goToForgetPassword();
}

LoginData loginData = LoginData(LoginApi());

class LoginControllerImp extends LoginController {
  late TextEditingController email;
  late TextEditingController password;
  late RxBool visible = false.obs; // Using RxBool for reactivity
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.offAllNamed(AppRoute.forgotPassword);
  }

  goToVerifyEmail() {
    Get.toNamed(AppRoute.VerifyEmail);
  }

  setVisible() {
    print(visible.value); // Accessing value property of RxBool
    visible.value = !visible.value; // Changing value using .value property
    update(); // Triggering UI update
  }

  MyServices myServices = Get.find();

  Rx<StatusRequest> statusRequest =
      StatusRequest.none.obs; // Using Rx for reactivity
  login() async {
    if (formstate.currentState!.validate()) {
      LoginModel loginModel = LoginModel(
        email: email.value.text,
        motdepasse: password.value.text,
      );
      statusRequest.value = StatusRequest.loading;

      var response = await loginData.postdata(loginModel);
      print("=============================== Controller $response ");
      statusRequest.value = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        // data.addAll(response['data']);
        myServices.sharedPreferences.setString("id", response['_id']);
        myServices.sharedPreferences.setString("email", response['email']);
        myServices.sharedPreferences.setString("pseudo", response['pseudo']);
        myServices.sharedPreferences.setString("role", response['role']);
        myServices.sharedPreferences
            .setString("cin", response['cin'].toString());
        myServices.sharedPreferences.setString("sexe", response['sexe']);
        myServices.sharedPreferences.setString("adresse", response['adresse']);
        myServices.sharedPreferences
            .setString("NumeroDeTel", response['NumeroDeTel'].toString());
        myServices.sharedPreferences
            .setString("bloque", response['bloque'].toString());
        myServices.sharedPreferences
            .setString("DateDeNaissance", response['DateDeNaissance']);
        myServices.sharedPreferences.setString("nom", response['nom']);
        myServices.sharedPreferences.setString("prenom", response['prenom']);
        myServices.sharedPreferences
            .setString("createdAt", response['createdAt']);
        myServices.sharedPreferences
            .setString("updatedAt", response['updatedAt']);
        myServices.sharedPreferences
            .setString("__v", response['__v'].toString());
        myServices.sharedPreferences.setString("message", response['message']);

// Set the step to "2"
        myServices.sharedPreferences.setString("step", "2");
      } else {
        bool warning = false;
        String errorMessage = "";
        switch (statusRequest.value) {
          case StatusRequest.wrongMotdepasse:
            warning = true;
            errorMessage = "Wrong password password";
            break;

          case StatusRequest.accountBlocked:
            warning = true;
            errorMessage = "Access forbidden. Account blocked.";
            break;
          case StatusRequest.nonExistent:
            warning = true;
            errorMessage = "Non existent user";
            break;
          case StatusRequest.invalidinfo:
            Get.toNamed(AppRoute.VerifyEmail);
            break;

          default:
            if (StatusRequest.wrongMotdepasse == statusRequest) {
              warning = true;
              errorMessage = "User wrong motdepasse";
            }
        }
        if (warning)
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
