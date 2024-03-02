import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inbridge/core/constant/Approutes.dart';

abstract class VerifyCodeController extends GetxController {
  checkCode();
  goToResetPassword();
}

class VerifyCodeControllerImp extends VerifyCodeController {
  late String verifycode;

  @override
  checkCode() {}

  @override
  goToResetPassword() {
    // Get.offNamed(AppRoute.resetPassword);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
