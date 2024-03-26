import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inbridge/Sprints/auth/linkApi.dart';
import 'package:inbridge/Sprints/auth/login/data/datasources/LinkVerificationApi.dart';
import 'package:inbridge/Sprints/auth/login/data/models/loginModel.dart';
import 'package:inbridge/core/constant/Approutes.dart';

abstract class LinkVerificationController extends GetxController {
  verify();
}

class LinkVerificationControllerImp extends LinkVerificationController {
  late TextEditingController password;
  late RxBool visible;
  late Rx<LoginModel> userModel = LoginModel().obs;
  setVisible() {
    print(visible.value); // Accessing value property of RxBool
    visible.value = !visible.value; // Changing value using .value property
  }

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  void verify() async {
    final Map<String, dynamic>? params = Get.parameters;
    if (params != null) {
      String userId = params["userId"];
      String token = params["token"];
      String link = '${AppLink.server}/api/auth/${userId}verify${token}';
      final result = await LinkVerificationAPi(userId, token, userModel.value);
      print("resultttt $result");
      if (!result) {
        // Get.toNamed(AppRoute.failure);
        print(userModel.value.email);
      } else {
        print(result);
      }
    }
  }

  @override
  @override
  void onInit() {
    visible = false.obs;
    super.onInit();
    password = TextEditingController();
    verify();
  }
}
