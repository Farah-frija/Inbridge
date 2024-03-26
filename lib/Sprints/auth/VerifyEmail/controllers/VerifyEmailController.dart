import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbridge/Sprints/auth/VerifyEmail/data/AccountVerificationApi.dart';
import 'package:inbridge/Sprints/auth/linkApi.dart';
import 'package:inbridge/Sprints/auth/login/Controller/loginController.dart';
import 'package:inbridge/core/constant/Approutes.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/network/handlingData.dart';
import 'package:inbridge/core/network/networkHandler.dart';

abstract class VerifyEmailController extends GetxController {
  verify();
}

class VerifyEmailControllerImp extends VerifyEmailController {
  late TextEditingController email;
  LoginControllerImp logincontroller = Get.find();
  Rx<StatusRequest> statusRequest =
      StatusRequest.none.obs; // Using Rx for reactivity

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  void GoToLogin() {
    Get.offAllNamed(AppRoute.login);
  }

  @override
  verify() {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print("validé");
      VerifyAccount();
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

  VerifyAccount() async {
    statusRequest.value = StatusRequest.loading;
    late Color color;
    var response = await AccountVerificationApi.postData(
        AppLink.AccountVerification, email.value.text);
    print("=============================== Controller $response ");
    response.fold((failure) {
      statusRequest.value = failure;
    }, (success) {
      statusRequest.value = StatusRequest.success;
    });
    print(statusRequest.value);
    bool warning = false;
    bool success = false;
    String title;
    String errorMessage = "";
    if (statusRequest == StatusRequest.success) {
      success = true;
      errorMessage =
          "A verification link was sent with success to ${email.value.text} ";
      print("mrigl");
    } else {
      switch (statusRequest.value) {
        case StatusRequest.invalidEmailAndPassword:
          warning = true;
          errorMessage = "invalidemail";
          break;

        case StatusRequest.accountBlocked:
          warning = true;
          errorMessage = "Access forbidden. Account blocked.";
          break;
        case StatusRequest.nonExistent:
          warning = true;
          errorMessage = "Non existent user";
          break;
        case StatusRequest.senderror:
          warning = true;

          errorMessage =
              "An error has occured while sending the email !please check your internet connection";
          break;
        case StatusRequest.verifyEmail:
          success = true;
          errorMessage = "User is already verified please login";
          break;

        case StatusRequest.offlineFailure:
          warning = true;
          errorMessage = "lost connection \n please retry";
          break;

        default:
          warning = true;
          errorMessage = "An error has occured ";
      }
    }
    if (success || warning) {
      if (success) {
        print("haw lahne");
        color = Colors.green;
        title = "success";
      } else {
        color = KRoseFonce;
        title = "failure";
      }
      Get.snackbar(title, errorMessage,
          colorText: Colors.white, backgroundColor: color);
    }
  }
}
