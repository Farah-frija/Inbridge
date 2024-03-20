import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbridge/Sprints/auth/login/Controller/ForgotPasswordController.dart';
import 'package:inbridge/Sprints/auth/login/Controller/SuccessPasswordController.dart';

import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';

import 'package:inbridge/Sprints/auth/widgets/LoginButton.dart';

class VerifyEmailSuccess extends StatelessWidget {
  const VerifyEmailSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SuccessResetPasswordControllerImp controller =
        Get.put(SuccessResetPasswordControllerImp());
    PasswordControllerImp emailcontroller = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0.5,
        elevation: 0.5,
        title: Text("ResetPassword"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Center(
                    child: Icon(
                  Icons.check_circle_outline,
                  size: 200,
                  color: KRoseFonce,
                )),
                const Spacer(),
                Text(
                    "Password reset Eamil sent with success to ${emailcontroller.email.text}",
                    textAlign: TextAlign.center,
                    style: kuserName),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: LoginButton(
                      text: "Sign in",
                      onpressed: () {
                        controller.goToPageLogin();
                      }),
                ),
                const SizedBox(height: 30)
              ]),
        ),
      ),
    );
  }
}
